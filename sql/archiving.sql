select
        i.*
      from workbench.workbench.indication as i
      left join (
        select
          arc."itemSpsId",
          arc."archivedAt",
          arc."data",
          lead(arc."archivedAt") OVER (PARTITION BY arc."itemSpsId" ORDER BY arc."archivedAt" asc) AS "updated"
        from workbench.workbench.archive arc
        where arc."itemType" = 'INDICATION'
      ) as a on a."itemSpsId" = i."spsId"
      where a."updated" is null and (i."updatedAt"::date > (a."data" ->> 'updatedAt')::date or (a."data" ->> 'updatedAt')::date is null) and i."updatedAt"::date is not null;