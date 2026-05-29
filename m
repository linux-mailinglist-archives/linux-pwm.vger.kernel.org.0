Return-Path: <linux-pwm+bounces-9196-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0P3oEYz+GGoEpggAu9opvQ
	(envelope-from <linux-pwm+bounces-9196-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 04:48:44 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D33045FC7C0
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 04:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BED6A3030D66
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 02:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0EB9368D76;
	Fri, 29 May 2026 02:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YyliQeA+"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010002.outbound.protection.outlook.com [52.101.46.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED4F29B795;
	Fri, 29 May 2026 02:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780022892; cv=fail; b=T9DHr/TCqVh2BhEE0f6qSYAkU58w0yQs+1P2lRFY8XYcIGQfSQkzFW33+prDTVj8t5mcuk4JS5yyozbanylC1D5VA+5MqdRuLK8bTkk8DqkFrFbNFGfOYdmINox/VwGMx2Ma58RaJ8FKYetr8NZMmWPC89xiWS5xCQ+0HTVH1us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780022892; c=relaxed/simple;
	bh=ILAGfmLttBCDuLwLz/paxZ2EBl5mOGpTt8qOjwnbbtU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=hhXdKTonKkK7HaZmJqpD+FOhcqtxV85HshiJhRk9aTIsNbzf25gMYJXv9ge9ZANP1EMQDoZhn/Q/0XRNs06dWu6EgbJ9pTqnfjWK2J6PiANzY3VJOLcxiraYdN2fghAtUyZrbEwJvQEQKLqIr67HO0eXYrXPwiGQDG8pRJl6auU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YyliQeA+; arc=fail smtp.client-ip=52.101.46.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XCAHdC7YDKL6cFPVyXOK0Nny/KDXFT71lvoDykoaiaaUQc6lEOwTgM2fO9ogEK7Gy9CTxMk12rKbqHaduA41Apync2qTZXl+DNMU3+9sb5xH4RgoA4sb1B5wd4FCi7TVl8KMRF6Q4KV2yNwuGdzPup5gWudriU7knV4tlMU+dKpJzkP97jZk+zW9BxPEe9tp88AYWKMoVUmoeEOCX7KHvVA17GAMA9ST/i+hoIC4xw1zNQlz7XbIlXpnZjlJI7tedaOz04jQgj/cT9NOrYCvtJr/EuZDiYFqA/7RWR5LVvJdstkGenBklGgCd5H5ZIozw5r2J6Ngrfsxe0MJ+va6ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=soX4Pjui2Cdi9AORSLpI9bbEsOPjwrTE7R+31Ps+iTk=;
 b=vaYhDdjDuXnUSM6X8Au8PovxDOwtblbZl3KIPR3BD9A0JHwpZ4+zsUE/uLL4qlfcO5qrasxGK/VhhTSEGQEYdeuR5LJ/ozGEeSIfgaRGxObaKToR7uIsZcRSD/FUpEFRHPruvbzy5KAXs6fRW2iYB99oD0G1BhMLhk38LrNvDcDLRIxDvNVaoA5cQ01TfXgcfxYmX655aqX/G07v0iji61M3JmHW/Vugn237riDvTmhQv+cEzrRd5A7ABsKeZzlwbrC9iAF4bi7ApzhCNAGajLIloSFQidu0iVwl4OxT/IimCiruvweeKfu5zrspVXQwj5RA4Bd8bkSAESk3vzLZVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=soX4Pjui2Cdi9AORSLpI9bbEsOPjwrTE7R+31Ps+iTk=;
 b=YyliQeA+F7o534yqjuVJWdRxhT8n92Hq/u+HhvERd1kHY0pCe1Lb3cqt03TrL6xmBF7C9LMdZ7nnX+Fbs5jeyw9nVmTIhIljxpNZu3pb/+kSoKwJYbCDNwVhNiqMpF4eSlik1vMA0pM92k45w9EY1mIb8wJQy55OP5ybjrzSP2Y6O5fk5DTrCGpvBHcQOsMEhlhMxpqbeCXsCCBSVpK5VU/rKEJ5K314koqpoMn+FpjjbX1o7TVvxwjL0LhYof7E+LP8em7c937yutXNf5a2qzDpGv3jWRmSmEHEbBRW9LZJexv6dzchij9gImAAvBpv97Nw/+XLYuc1P2MpNka/7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 02:48:02 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 02:48:02 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Fri, 29 May 2026 11:47:26 +0900
Subject: [PATCH v5 5/7] pwm: tegra: Parametrize duty and scale field widths
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-t264-pwm-v5-5-7bf9e405a96a@nvidia.com>
References: <20260529-t264-pwm-v5-0-7bf9e405a96a@nvidia.com>
In-Reply-To: <20260529-t264-pwm-v5-0-7bf9e405a96a@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Yi-Wei Wang <yiweiw@nvidia.com>, Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TYCP286CA0085.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::8) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH7PR12MB5685:EE_
X-MS-Office365-Filtering-Correlation-Id: 49f0b840-e0af-466d-bd7f-08debd2cb34e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|1800799024|366016|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fSmEafEIb9J5yJHglwDibh75NJUW8r1B03wOpypbw81w7F5GUzp2wDORb9SPAdW7UEWkisqVcKMuIocrue6uD93AUz2WmHFNTDpnze22W9Klf9j26NQdy87TWXTKSzW6I3bLYyznTwdGA1OhQFCP58XYIV2T3yiFF+cXHyB58ajT/RuSfE79wG1Q7DxHS6boSLnn7O94LK/bVrHdYq06HE+Iyvq84mFUOkyJYfEsATIn6GU/UcPTXFMqNhj6cH1bjeGnR9EPGE4KE1Lty3tz6P9KIA37+7fSpTAEf//+6GaQHA37dcE8KwPXCDcE0ChEMlokZV98cb5svZ8WF6Z04XIU9sbaReBtNsieXoxPTlMAAOby5DytEq4YGI+yMI8tReSgl+MRYXJkP7hZfvHuMyN58z9+BxPO6ahZ2aHgfPTMJ09bXAPLgiZ9j0x+EhWQpcBK/si6pqiRlaYi+T5Hihr3XETvXzBCrquha59IXd9t0aHfyQNVHUDeY617KxexqTbqdST6WbHOhCet6SmAQ0O171kIANwNP27TzCKK/jMueleKklW2UelfLVciK6zoD+IfkrIjFD+SbdRawgw+c1d0Mi2mEAOqzbrArcXidYgF0HGX2CvHHsJ87yM8v11GdR1hHPbJ5BXeyBGBT36ArIQjvkNMOb/gIzMbtAyEmAgsdsrh1WO7sm+pBry6QG+u
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WWV2QVlTbkVYMGsxUjhULzRlTTlyN3RMcHNlN1hRbExFcHNwRDdELzF6WVNX?=
 =?utf-8?B?TlJxNlNjNlRKNE9NR3FuVWhPeUVPenJDQy8zL2E2Q21aRUhMU0RpMzBaMWhK?=
 =?utf-8?B?MW1qQ1kza2tQdE5DUlNBU1RjUm43bzZWbWxQQXptdGN1dmdnRVBLbkQxZE5P?=
 =?utf-8?B?VUU2K3JtUmsxaWIzK21waVdRdVBDbXkvOXdmTDE3WnZYOXFvZWozeXozcnBQ?=
 =?utf-8?B?c2NwTERmRVNpcVc1bDRvKzliZzVEdFlpRUJkNXVIQjl5bFRPVWZWRDZieDg2?=
 =?utf-8?B?MFdTNTRDaEtoQlR1d0ErTVhCY2xvZXUvczg2Z0dvUFpKa0xVMEtuT3dKYTd3?=
 =?utf-8?B?Mm0wMEFsSkdjeUg4K0IwcitwczJiSlZCUnNuVUhjM3ladFo3UlAraExaUG04?=
 =?utf-8?B?YVRYekJZUWdIenVidmZudGhBK2VFSHpmNWUzUG5SNXpxdjBhV1ZtTUVudjNE?=
 =?utf-8?B?d0tMT3NxRkJFWmZjRXdUUG96S01jRjV5MHpWTGE2akU2akY5ZGNuSUtWblpZ?=
 =?utf-8?B?UFhZQkJFY256aDlFUVF2dVlxNjJIOExtSktzeTArditHSUZORU1SaGNDZ3lJ?=
 =?utf-8?B?OWx3YXBpRjFtdi9GTlhXQzR6TENHZVJqenB0dFBycUw3RFBYeDhJTVNkVGJ6?=
 =?utf-8?B?RiswR1RMaHczdVJ4UC9rWGlwbE80N1BiSXpHM2szRlY3Kzk1VEhaY0ZtRFh6?=
 =?utf-8?B?ME1TakJhcUo3TkhkZVg2cjE2UnNyR3ZFQXFiZWM2WThNaVdYU0lDbCszcXMx?=
 =?utf-8?B?QTJSWXlNMFB1VURzcjhjWEltRFRlS3RpNUxjRjQ2ZmY2azcvQzIrUXk4MXE5?=
 =?utf-8?B?ckZOcElJQ21CTmhHMG9xK0Y2Yi9jeUFLdkFhdU9QM1ROMlB5YVhEZDd1bDE5?=
 =?utf-8?B?UFdXVDJSYmlzQWo0VzVjcWx1U2dUOHRRdzZtL1BidUtlMEhTTVF3cElkbUE4?=
 =?utf-8?B?cThjQWV3SXpIN0ZJTmlDY3R3T0FQaUV3bjhMM3lXTVlZQzg0RFlWN1pmcTNw?=
 =?utf-8?B?NnZqMEV2bDdKdUdnTnovekdGdUxMZ3NaUElYYkVmNW1jTEJyeHZEcjc0TUFw?=
 =?utf-8?B?anNWUEtqSjU2c0dqRjlOaXdkdlB4STRpNEJwWWh5TTlwNlZWYjNmMEpPOVNi?=
 =?utf-8?B?SWZTN3ZBRTd3eURUUjNrYzU3Y0ZIR253cmltZ2lNam9XUlcrSTRZdnZhYVZS?=
 =?utf-8?B?d3ZXOFphWTN2aWd1c3ZIN1VMU1B4SzYwZ05udzVmbCtqbm9mMHQ3TnV1Tk52?=
 =?utf-8?B?TzhOZUpNVmJaOUpFRWxONzZORnR3eEx0eFY3cmhzaUZKTVRQaFp6YjRNVGNC?=
 =?utf-8?B?Y3RzdW9wNi9EdDdIaEIxYkFDdW1jdUpOY0krSUlvbEpRYmRJN0pjTFhwV0xM?=
 =?utf-8?B?cG9JNm5qY3EvV2J6S0hSekZsYWJzSEgwZlFNN1VBZWxJbjQ0My9OTGJQSTNO?=
 =?utf-8?B?b01tdWtMdHlPU1V0NGxYZnQzdWtEUkZhMCtCeTJFOWtiN0ovRnBtczlPRnJh?=
 =?utf-8?B?bTQ4T1Nmd1lwMjBKakZML2xlOEFHQ3VJY2c1ODJEUk9MYWhDU2dYeFFPc0ND?=
 =?utf-8?B?bVd1UGd4OGxPVVNqb01VVzllaGM4d01VMUZnU0ttOTdHSzRkTHVlakxBRkp0?=
 =?utf-8?B?cjhwaW5WbDUvM3lMUyt2UVVXSklLR1NROHhjNkUzeEVjaTJLa05BazZEVmp6?=
 =?utf-8?B?NVJNQjhDL29aRVJlVTVGeHZiRkxyUnVXbjRBeFIvWm1VaUYveDBLWW1mTURo?=
 =?utf-8?B?WGZxenRoRWZMMUU0UjlrbDVQVWR2UXBWWFNQc3A3V1VORUsyM3lqWWVTSHRq?=
 =?utf-8?B?MUJYUE1QazhOYnJZejE2U01jUWNaU09wWHdmaWJ5SzV5YkIvOGFoNmpTQWUw?=
 =?utf-8?B?dXBiSWNFSVpxMWdId2RkN1lXNFpsMjBlaWMydlRHRnBIOVFzaDI5dkVZUDhj?=
 =?utf-8?B?TnNHS1JQbEs3RVUrVzMzSjd2MVpyd2ZYcnVCa3VFdUZRWXRzNGk4YzVxRzhN?=
 =?utf-8?B?dndUYXBscWNXczhCdG9Fb3NvSTFJZkxrU3R0NUhaZ1I3aUNGbk9UaXRmZlFT?=
 =?utf-8?B?OHpTRFVkNU5rU3k4Vnl2cXNhblBBNmNKbTNtc0diN0UxWG1IcE9OZmJmOFhr?=
 =?utf-8?B?MWQ4ZEhjTGZaRzVYOUpBYTF6dEhJWFBUVWdCL0ZRZkxaZXZ5OG5idGt6cnFr?=
 =?utf-8?B?NW9vRFJXUXo2eHRLd1MrK3hxSGtKS2V1YzBvOXdVVCs1UTl6Z1hYUGNpS3Zh?=
 =?utf-8?B?NUsySGhaTStPMUJ4VVQ1TkZsWWc4RFVWMnkyMUc5SVVaQ1o4eVAzV3Z1MzBy?=
 =?utf-8?B?OXNnaEFwVFBONjFmTEU1ZFA3a05HK2d4L0srWnc3NXFmenJ2WU15blc1ZzQr?=
 =?utf-8?Q?jkRaylv5cUv9u+pJs491vrbnkuNwNwiHG1F9NVAw3A1G9?=
X-MS-Exchange-AntiSpam-MessageData-1: 2R6OBdoIwNcjwg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f0b840-e0af-466d-bd7f-08debd2cb34e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 02:48:01.9755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uJwb1ZctPRy+sNMgIOWrERhHkbL7m3OgWTVEQTug82B9f28GibESJ0c7iH1ppswt5y3I73Le1bcsOgx4/pHFfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5685
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-9196-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D33045FC7C0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Tegra264 has wider fields for the duty and scale register fields.
Parameterize the scale field width. The depth value becomes
disconnected from the duty field width, so define it separately
and remove the duty field width definition.

Co-developed-by: Yi-Wei Wang <yiweiw@nvidia.com>
Signed-off-by: Yi-Wei Wang <yiweiw@nvidia.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index c82d537436a0..7c7b884d4436 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -52,15 +52,17 @@
 #include <soc/tegra/common.h>
 
 #define TEGRA_PWM_ENABLE	(1 << 31)
-#define TEGRA_PWM_DUTY_WIDTH	8
 #define TEGRA_PWM_DUTY_SHIFT	16
-#define TEGRA_PWM_SCALE_WIDTH	13
 #define TEGRA_PWM_SCALE_SHIFT	0
 
 #define TEGRA_PWM_CSR_0	0
 
+#define TEGRA_PWM_DEPTH	256
+
 struct tegra_pwm_soc {
 	unsigned int num_channels;
+
+	unsigned int scale_width;
 };
 
 struct tegra_pwm_chip {
@@ -105,22 +107,22 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 	/*
 	 * Convert from duty_ns / period_ns to a fixed number of duty ticks
-	 * per (1 << TEGRA_PWM_DUTY_WIDTH) cycles and make sure to round to the
+	 * per TEGRA_PWM_DEPTH cycles and make sure to round to the
 	 * nearest integer during division.
 	 */
-	c *= (1 << TEGRA_PWM_DUTY_WIDTH);
+	c *= TEGRA_PWM_DEPTH;
 	c = DIV_ROUND_CLOSEST_ULL(c, period_ns);
 
 	val = (u32)c << TEGRA_PWM_DUTY_SHIFT;
 
 	/*
-	 *  min period = max clock limit >> TEGRA_PWM_DUTY_WIDTH
+	 *  min period = max clock limit / TEGRA_PWM_DEPTH
 	 */
 	if (period_ns < pc->min_period_ns)
 		return -EINVAL;
 
 	/*
-	 * Compute the prescaler value for which (1 << TEGRA_PWM_DUTY_WIDTH)
+	 * Compute the prescaler value for which TEGRA_PWM_DEPTH
 	 * cycles at the PWM clock rate will take period_ns nanoseconds.
 	 *
 	 * num_channels: If single instance of PWM controller has multiple
@@ -134,7 +136,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 */
 	if (pc->soc->num_channels == 1) {
 		/*
-		 * Rate is multiplied with 2^TEGRA_PWM_DUTY_WIDTH so that it matches
+		 * Rate is multiplied with TEGRA_PWM_DEPTH so that it matches
 		 * with the maximum possible rate that the controller can
 		 * provide. Any further lower value can be derived by setting
 		 * PFM bits[0:12].
@@ -144,7 +146,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		 * source clock rate as required_clk_rate, PWM controller will
 		 * be able to configure the requested period.
 		 */
-		required_clk_rate = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC << TEGRA_PWM_DUTY_WIDTH,
+		required_clk_rate = DIV_ROUND_UP_ULL((u64)NSEC_PER_SEC * TEGRA_PWM_DEPTH,
 						     period_ns);
 
 		if (required_clk_rate > clk_round_rate(pc->clk, required_clk_rate))
@@ -166,9 +168,9 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 		pc->clk_rate = clk_get_rate(pc->clk);
 	}
 
-	/* Consider precision in TEGRA_PWM_SCALE_WIDTH rate calculation */
+	/* Consider precision in scale_width rate calculation */
 	rate = mul_u64_u64_div_u64(pc->clk_rate, period_ns,
-				   (u64)NSEC_PER_SEC << TEGRA_PWM_DUTY_WIDTH);
+				   (u64)NSEC_PER_SEC * TEGRA_PWM_DEPTH);
 
 	/*
 	 * Since the actual PWM divider is the register's frequency divider
@@ -184,7 +186,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	 * Make sure that the rate will fit in the register's frequency
 	 * divider field.
 	 */
-	if (rate >> TEGRA_PWM_SCALE_WIDTH)
+	if (rate >> pc->soc->scale_width)
 		return -EINVAL;
 
 	val |= rate << TEGRA_PWM_SCALE_SHIFT;
@@ -319,7 +321,7 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 
 	/* Set minimum limit of PWM period for the IP */
 	pc->min_period_ns =
-	    (NSEC_PER_SEC / (pc->clk_rate >> TEGRA_PWM_DUTY_WIDTH)) + 1;
+	    (NSEC_PER_SEC / (pc->clk_rate / TEGRA_PWM_DEPTH)) + 1;
 
 	pc->rst = devm_reset_control_get_exclusive(&pdev->dev, "pwm");
 	if (IS_ERR(pc->rst)) {
@@ -398,10 +400,12 @@ static int __maybe_unused tegra_pwm_runtime_resume(struct device *dev)
 
 static const struct tegra_pwm_soc tegra20_pwm_soc = {
 	.num_channels = 4,
+	.scale_width = 13,
 };
 
 static const struct tegra_pwm_soc tegra186_pwm_soc = {
 	.num_channels = 1,
+	.scale_width = 13,
 };
 
 static const struct of_device_id tegra_pwm_of_match[] = {

-- 
2.53.0


