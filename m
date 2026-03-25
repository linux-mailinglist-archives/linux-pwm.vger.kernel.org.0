Return-Path: <linux-pwm+bounces-8364-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNXGJjC4w2litgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8364-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 11:25:52 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1C2322E4C
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 11:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E1BA30BD81E
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 10:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8A33B8932;
	Wed, 25 Mar 2026 10:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EAZmt4zH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010000.outbound.protection.outlook.com [40.93.198.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547983B7748;
	Wed, 25 Mar 2026 10:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433899; cv=fail; b=IB/dj76ZHqCdWijJaAAWZp8Qj7v6q8/lZ2zpniaVYaboh7SlfUvUHTSV8FndRlM0ibztfvn1HFFHqn7tbLf7xI729oqi8xgJW/RDtjWnCtiNb7zW0TgTO/eGMq8Niw7Im7ATAHzNJxc8Igc0nLqVmNyQztrpoCX2EpEJkw39qq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433899; c=relaxed/simple;
	bh=IWXVKMOzEauRJgtnkd36iseIw+8u8718aDzc3frkdc0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Lm+KGYw3adV7GOq2g9sSU3QWbr18YRaA/94e2qUZ76qrKpejUn+gjdk40YMieMxhwqetvL6aDL9lKVnQWr/2FFtiq0bVPPxUN/zlhzThnl97AaBumB9fQYh4xNCIpIANhnCay4Im8R+a5L0gB1Yeho6BJsxK/NbUt+fQvFfF6/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EAZmt4zH; arc=fail smtp.client-ip=40.93.198.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RT7I83XJ1D98GF1QhEvw9ZiOpgqxj9GBMz4IR+qTmiYtS3oVr4ZGUrcA8ZNr4qrK3kCH0r280ylTRhIw5AkrvKHQsmB4isKw4946pdabBKT7FMqqYrnyS2uBVJKNUqZlqEUHTdBF5eOY6q2MegMdWHOoBhRBJOqdQpQQ3tazyx9OWnuM6/j+v7mfFCLXittW8mFjUhRRQ648Wlrn4bzlMujaS1Ud0z450g9V3ryn/pVzJtMM2fXTPLeHKsOi5+V0e6l7rYQdOT5pFWXOyHaDEk8fx9J+KGYwZH1NpUe6ZuCEz/OKNjLMXILe1Xpx783PKqy2Uly1AOfruaMlK8uCaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y34SQhZ1jJ0NlbPYP7Z5/d4wlBqLWpPwtcEYHj1e80k=;
 b=lqbin+MVKSs+0mJf50aI5Um6noHSsmuKOnedAbZQhV15UZyZTZALOSkP9wV5tQmMEuVG8/PHTyE91eTgU2jbExcm5uQUx1Y/AgK3GCFqKdUuS8Dc4eNyW5+8rwPbynaisek+Fv7xtAnfPGnlHgGzXbaIWVt7k1GVH7L9hZmBe5G0PDETlSKwbuENUB9W7iptw2XalKQw/OaW71Dd0jbqEy/n2KuWYF7jphuPk29Cmlibfn52KDq2nmPQeGfMr2rKH40zrI4ZO8I7h6q7pLz0AJtRDaLrgYXJ7pBuC+7emlIapbDWr3eGj/dNDfbpBzphJfVTOa89nK0umrveXtJOxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y34SQhZ1jJ0NlbPYP7Z5/d4wlBqLWpPwtcEYHj1e80k=;
 b=EAZmt4zH7NPb9yr/GuSVhzWe2b26cTcWqzx9CQltWMDHYWmYtobsE+Mn4M1LXi8NTPhroc7b26oqF0WxUSf+ZOWd0DVpj8J6Jc505Mlyq7BKvuZ8KpAa1crW0v+7dTDfcZFWpMfFU2MtjnALOWxih34jW45xb30j8Sh7IGn4XLdoJEhAEriqTEItaY6Ma/Q1xeKBYiPQ6sWquXtn7MIm9QzMT2JzF+fKtZp/RBj5iLJtzBjIw6zIy7wJ+4AkQ7fz3RpJL3ClTOTldqhYxv1Akwq6lDiTxyXJZquFUn0QhIDgK9jse1iwwxf5NqdZEwyF1ogd7w+efc1bfWb8nRph4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS5PPFA3734E4BA.namprd12.prod.outlook.com (2603:10b6:f:fc00::65c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 10:18:09 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 10:18:09 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Wed, 25 Mar 2026 19:17:05 +0900
Subject: [PATCH v2 7/7] arm64: tegra: Add PWM controllers on Tegra264
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-t264-pwm-v2-7-998d885984b3@nvidia.com>
References: <20260325-t264-pwm-v2-0-998d885984b3@nvidia.com>
In-Reply-To: <20260325-t264-pwm-v2-0-998d885984b3@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Thierry Reding <treding@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TP0P295CA0002.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::15) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS5PPFA3734E4BA:EE_
X-MS-Office365-Filtering-Correlation-Id: a913edb5-56e8-4d89-858f-08de8a57cff9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	zE+UfE4yCLOYRinX7SbhdLsSNsHVKflV5ZT9aI55lzkq5dTP0voir0GZ0UaaTDfDy3VSxY6HyRopAk7PVgE1jvJmPGyEX6HIdHGNLfbwZ8JcdV/Mh7xdhMCdi3/XTrr9Ptr1rzdbKIMwOMI3EaJ3QfdxPeFf2MDQfhFv5R0QsgBfQFv7l/g1TnKZ3WlFPlYdG81G96pdcrYhJp4orOuG92nBu08JcNiofYKd+ERh7y9DpT+LGDe4xtNy9SmtTCmEU8crVlvOhjjL+PGvci07qx4cZVaqhX8q2jgmUFMZTIMK1OGvyfgnoPORvm5B1PggDpCsDggR6HK7a3jAszlM0rAUn+NHo+YQnnHRYtJtaa+9ZtG8ehHZHNw2mMZaorL4r9hkJMCD1swBn6/moTO0BAxnyvQgimooalEg+d/DwPpqgN21M2602w8VbvmJ4oJp2iCCsBc3YyrEsoxH/ecCY0db2mrGQrr8WLCYkLJrTxEbcJ95YBJax04j5N3MGlP16k/vCS6RS0Cb6OV5gO4z14NVKd8ggD5n7BDA2QCs8SNsDhqzo1HdtRDfPQxnhu7T5/ust9FgjGYhTKw/tgapiudWkJcK/OpZmrWJLu7s1qztjnhQzy6wA5iUYm+dhXk/W/yKxFGO7RkJWqG8xJ7M8EjMgtftnyHjq/22chU3o17Kc5v67NAYguejSXqD32fjaTvmQxexuBNkl3fetScz8tHgOERyzjciGsB2t3X9lxg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFNhc2F0L1huZEFPbHF1MDNxb2JKZWJWZGdCRTlpeDlOb2RlZ0VkSEI1SkZ2?=
 =?utf-8?B?dzQ3dlBYK1g5cnljbHNDektCWXdzd1A4M3hoSFE4WTV2ajh2UndoQjI3cWFS?=
 =?utf-8?B?QS9adzdSeE1BOXpRTmN6cnVMYTdta245cTVMYXFNOCtKYjk5ZmFZTk5CMFlw?=
 =?utf-8?B?UEFpQlV5QkI3R1R4ZWRYc1pVK2NiSFRuM2FuYXA1MENCNVY4TXlLOS9LS0dz?=
 =?utf-8?B?WitpSjB3V1ExUjQ4bXR1RmNxeXFJSUxJSHpXSS8raDA3RFd0N2ZLaHRZUExT?=
 =?utf-8?B?bDhSTmFFaDdUTFd3YnhtZnBjbk56cFZMT2RYV1F6c2dWTnl6dFlzU0hYaEJn?=
 =?utf-8?B?M1JKTWhoenU5MzRUanRtQ1JFOEdOSkJJeWR4dGZjU0pDaU5EZkxPb2Z2UVo2?=
 =?utf-8?B?S3BEakZtSGFjVDJyMXBQa1QxbWwrcUFWWHh5NHZyQWt3aXV4YVg0R1BBakJI?=
 =?utf-8?B?eGdZcm5QTmdlOVp5VTh6NENJZjdjTm93T1RDVmdHdHZ2UlRGYWQ5a0Z5c3Vj?=
 =?utf-8?B?KzVyR2orakFnVXdRU3pTMVRWNWk4eFVHVEltc2xkdGJvQmhXaWhPcVBVTlNy?=
 =?utf-8?B?dEZIQlJybDBNMnMyUmhlQzZnVEVuemRrU1g3NkRnOHNMNnd5TFdUeXdSRUUv?=
 =?utf-8?B?T1JQc2JyeXR3UjJwNVhZZk5GRVhTUklzQVRpb3dQZmVxbDYrQTJMZzNKcXQr?=
 =?utf-8?B?WHBiRU5DTVAwWEE2OHp1b0hQdi80RTdLNU1xaDg2MkJnc0lyR3Z0d1dyUDF5?=
 =?utf-8?B?R0JBNUZhdy9rUVRSTXUyZlV4T2N5WS9ZSmJGblBUZ1B3aDBibTBjdExrYkxV?=
 =?utf-8?B?K2hXSnA4S2ZPSU9WLzBnOElPWFFDNVR5WG9xbkVoNFYyeElaWHFDdHRkUk9R?=
 =?utf-8?B?bHV3VU9aL1Y4bmo2dUczZ2I4SVI4TW9JZGYyOU1TTzlVUzltVzFHTStjTmtI?=
 =?utf-8?B?WCt0VTBER1N1OXRVeFMyaGVIS2lhOGZWOVB5MExpOU80TFdvWk5NSTVyUFMw?=
 =?utf-8?B?bm44NDF6aUZGNnZ5TzdDTFQ4Zk01QlNLYWVoZWlaOS9SNmsyVWVOKzc0dTNx?=
 =?utf-8?B?SW5FZDBlem1DVlVZMmI1aGQzODd1ZWlwNFlTWmNvOGZpWkthT0wvY2FvZFNs?=
 =?utf-8?B?eGloVE5YOXEza0xWWVBDMi9nZ1h6c3NDSGhIVFlTYmpPUnZNa244b2F0cUxU?=
 =?utf-8?B?anRYc0R1NWoxSEtWNEZNd2FPcmhWa0psaTJXenpEUzVFS2x6YW1MbnJrWjdk?=
 =?utf-8?B?QjMza01OMko1alR3bnRXWUczRytPT1NBeDk1QkpramhZME9sb2QwNWlDMmhF?=
 =?utf-8?B?MXBiRUtXNldMU3Q4S0g4NE9WeTFwMGh5YWRheHBpRXFVMTdMRnlEMEExU29s?=
 =?utf-8?B?WGFOa1c0ZlEzUmlYUHIzbzBQZ1ZBRGVQZERhWmRyOWcxN1N1bFFSMDhteFI2?=
 =?utf-8?B?bDJPSHR1NlVJc0grTE9GZFhkVzU0N1FCMHNRL21ibzZNRmZCNkpBODlMUTVQ?=
 =?utf-8?B?cW8wUFkzQitnSWNYdEswa1U2VUhVVzJuNk1tMFhDTUFVa1FYcTR4aU9PYTha?=
 =?utf-8?B?a2tZdG95QlFlOHd4cDlIWUQvcXVQZjk1NUs5SHl4cVh0cFRuTHBNeUZPRGp4?=
 =?utf-8?B?VkhCOFZLZXIwdHN5RFRZaEpUTm05aE1pcSsyd0Zjek5ERDBDR2F2bTkxRXhK?=
 =?utf-8?B?RUdoRXRZQUdwRHhYVktUZWFZRlA3UTV5bjhucmZkVkNwUCttWEJKeWZqMDNM?=
 =?utf-8?B?OW9WNEVBL3lpdFNHM1p0UVdYekdVNGZOT3p4cG14V3QwVlNXa3pUTzJTdGs5?=
 =?utf-8?B?TGw0TndyUUhzcXRRMVdKWlhjcGlRQzIzRW5GQTg4dWV4M2ZYamphWkF6VE9x?=
 =?utf-8?B?bW9wb2Y4bVE5dCt1OVJPV2VYRzlHb2s1WVF6SzdKY2x0cWsxQkkrQ2RseDFh?=
 =?utf-8?B?TUw1bCtPQjQ1ODlFbitKL2ZXaDJ5YTJsY0tsRFV3eTZVNXJMUlJuZFhXWlQx?=
 =?utf-8?B?T3cwL2FORmxNOHlGaUYraGZRelRIU3RhWWlEcy9nM1pTdytxTFQ2NnZLYTNK?=
 =?utf-8?B?cTB5cERPMy9ySVlwdlNRNGh2c0dvNUxkMzY3VUx1T2R3T3JUemJycFU5enBC?=
 =?utf-8?B?L1ZzMjRpVnhoOGo2N1FFeDZqYkpWNFM2MVdod2x6VmtvYlp3YXJaeWNNcjNK?=
 =?utf-8?B?Zlo3cHBIZHVGajhzOENRYUwvVlZoazdEMGRqYjdydmpReHBwLy9keFJDNTgr?=
 =?utf-8?B?c0VidVdlK1hlTGxtS3ZTQ1JXb3BOWm5zWE5wRGhvNHFCK283S3FSZHFsbUJl?=
 =?utf-8?B?cDFOR09TQk1jTWszaTZGK1hNVUd3bzJjaWRzQUdvamYzMDhIdGs0eHRuOFl3?=
 =?utf-8?Q?a5LFZWt3+jFj9S481iB0bNq5FnYvOhMiTz0a4CeBBfxJe?=
X-MS-Exchange-AntiSpam-MessageData-1: H9IXf5czcbskRg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a913edb5-56e8-4d89-858f-08de8a57cff9
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 10:18:09.1678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcUReNsTV5SGfjHjpjag/mtpW+CQWGuxX9qcLy7qKCgwG/mha+pK+gAJUmGrTTNiZhsZoWDtRi0nk992Loxa8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFA3734E4BA
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-8364-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A1C2322E4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thierry Reding <treding@nvidia.com>

Tegra264 has a number of PWM controller which are similar to those found
on earlier chips but with some added functionality.

Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra264.dtsi | 72 ++++++++++++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra264.dtsi b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
index 7644a41d5f72..13fd04068016 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264.dtsi
@@ -3336,6 +3336,18 @@ i2c3: i2c@c610000 {
 			status = "disabled";
 		};
 
+		pwm4: pwm@c6a0000 {
+			compatible = "nvidia,tegra264-pwm";
+			reg = <0x0 0xc6a0000 0x0 0x10000>;
+			status = "disabled";
+
+			clocks = <&bpmp TEGRA264_CLK_PWM4>;
+			resets = <&bpmp TEGRA264_RESET_PWM4>;
+			reset-names = "pwm";
+
+			#pwm-cells = <2>;
+		};
+
 		pmc: pmc@c800000 {
 			compatible = "nvidia,tegra264-pmc";
 			reg = <0x0 0x0c800000 0x0 0x100000>,
@@ -3538,6 +3550,66 @@ i2c16: i2c@c430000 {
 			status = "disabled";
 		};
 
+		pwm2: pwm@c5e0000 {
+			compatible = "nvidia,tegra264-pwm";
+			reg = <0x0 0xc5e0000 0x0 0x10000>;
+			status = "disabled";
+
+			clocks = <&bpmp TEGRA264_CLK_PWM2>;
+			resets = <&bpmp TEGRA264_RESET_PWM2>;
+			reset-names = "pwm";
+
+			#pwm-cells = <2>;
+		};
+
+		pwm3: pwm@c5f0000 {
+			compatible = "nvidia,tegra264-pwm";
+			reg = <0x0 0xc5f0000 0x0 0x10000>;
+			status = "disabled";
+
+			clocks = <&bpmp TEGRA264_CLK_PWM3>;
+			resets = <&bpmp TEGRA264_RESET_PWM3>;
+			reset-names = "pwm";
+
+			#pwm-cells = <2>;
+		};
+
+		pwm5: pwm@c600000 {
+			compatible = "nvidia,tegra264-pwm";
+			reg = <0x0 0xc600000 0x0 0x10000>;
+			status = "disabled";
+
+			clocks = <&bpmp TEGRA264_CLK_PWM5>;
+			resets = <&bpmp TEGRA264_RESET_PWM5>;
+			reset-names = "pwm";
+
+			#pwm-cells = <2>;
+		};
+
+		pwm9: pwm@c610000 {
+			compatible = "nvidia,tegra264-pwm";
+			reg = <0x0 0xc610000 0x0 0x10000>;
+			status = "disabled";
+
+			clocks = <&bpmp TEGRA264_CLK_PWM9>;
+			resets = <&bpmp TEGRA264_RESET_PWM9>;
+			reset-names = "pwm";
+
+			#pwm-cells = <2>;
+		};
+
+		pwm10: pwm@c620000 {
+			compatible = "nvidia,tegra264-pwm";
+			reg = <0x0 0xc620000 0x0 0x10000>;
+			status = "disabled";
+
+			clocks = <&bpmp TEGRA264_CLK_PWM10>;
+			resets = <&bpmp TEGRA264_RESET_PWM10>;
+			reset-names = "pwm";
+
+			#pwm-cells = <2>;
+		};
+
 		i2c0: i2c@c630000 {
 			compatible = "nvidia,tegra264-i2c";
 			reg = <0x00 0x0c630000 0x0 0x10000>;

-- 
2.53.0


