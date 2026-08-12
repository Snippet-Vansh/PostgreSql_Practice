SELECT 
    created_at,
    actor.login AS user,
    repo.name AS repository,
    JSON_EXTRACT_SCALAR(payload, '$.size') AS commit_count
FROM 
    `githubarchive.day.20240101`
WHERE 
    type = 'PushEvent'
ORDER BY 
    created_at DESC
LIMIT 10;