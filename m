Return-Path: <linux-pwm+bounces-9192-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDrUCxP/GGoEpggAu9opvQ
	(envelope-from <linux-pwm+bounces-9192-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 04:50:59 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83A3F5FC7FD
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 04:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E0E2302C5D0
	for <lists+linux-pwm@lfdr.de>; Fri, 29 May 2026 02:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E52A1369D4C;
	Fri, 29 May 2026 02:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GrMVmUdd"
X-Original-To: linux-pwm@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010001.outbound.protection.outlook.com [52.101.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9257369D46;
	Fri, 29 May 2026 02:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780022871; cv=fail; b=R6UY1khxNnZJJJ9jSLr6UZGtcpltE8yn5yd+REsuyYklr4CG9UjnkkvLbIXNM8u/sDaP25Ha4zqfFmoMd6Ah1RJRqrG6IywUwixWbVy3bV6LIZ9thmB0lQlGr4wHySK0PFclIImRVMIzwPWZUpExsYgMd7mZi2VHesClemK/xdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780022871; c=relaxed/simple;
	bh=drQbcWRvFfGOTo/046NejrND/wD0lWVdRL5CxwyMzJM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=M2Hn0TefAB0Z63GPip1+iNIW5WMEZLlF7CglgUlLVQ8+s5H0D2Eqbp/48gKkzXmt1NLVde4IrFXBWFaAsAhxHkxZdxNdrYZiziVzfUxQyr4NUkWaGK74Mra4dmkbIGv7E6o3X0bMNm8wViEQihpgoda77pUWBXgfwvfep/mVAIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GrMVmUdd; arc=fail smtp.client-ip=52.101.201.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e676DmAPw1oucmLwK/aWFgEWi1tMxuwyqo3JOg2mKoIX6LJ/PJNTQny6M8tSIfDq9cSrefPC0t92F/2QJHWtgiZqBQdS82+AfCysOhZrEX2GdNynrAO6S9bARWCd739/XLvVanClzRh/7R5kvuV0eBoLkDKUDU1DotybAZijKPxk9wt27oQZVgxJcuNErHO3c1CpPXwiEaxq1E7YQzcb+/0s23f8zyTHcHHVAQlgwrH9681YHO3MmPFpnWRx2X1UPOOF937KRUUpvkQkJAAwEwZOaV8ysuwuShGSvs/cCDzo+WlBU90POoG5faTukfUANuD2pv3/1+vUw9qkTjLU/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qeXOmS98gHrjrPVSYQloZdWXQMz1sWVQHrHgY4Tptxc=;
 b=coL3+1BtggWHhM5nXsl/JBU7M1SeiyZ40ghzuGUdDhDBNx/0tOP/SvKovkPGzNeJ5oANCxWBgQOKvZNepus/DGV62CYC8Ur73mwb3PoFsZXEHDBJyvnkUZgJTAA3+nT4vEdbRoCXzycESYSeO9jXpbOsh6UVyrTVvvVV5Vpstp9ETFY5YyATDo7FD7LCRoTNthI7Uhe+lfLpTvEdAcdlDocKGPO12QYq5rGekOYzujabWzrjyqhUkmMS9r0eWcpnmRevABLuZLF6LvLvOjoZqoDsKQt2UWxbe587MSvwf3vqku5rhO6OMHnh+TeUAPQf8dBHwFlDr9AMwZkhEG9vWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qeXOmS98gHrjrPVSYQloZdWXQMz1sWVQHrHgY4Tptxc=;
 b=GrMVmUdd6KnW1XjndSUqOCLeZYV/j/rSoReUpFNAh2HYr9cP5YiSLyO9ImlAgXIoXC00rEmyTk2fY1C+lQL2U4e/5eEDPB82NyYcsx0Vho6+8HNfZXoSR/QsSQw2ENAxrAr9+cSE4VKwAiAgzHrp22iMJG3Ud80mIytQ6EvK2trcCb3kt7w23pTr9I4Dn14QyG19C4p1q01AvHoVxXs6plr+HlvEIGFDGExvFyueC+6PrXxM6oc/1iF3tVW8M+xvBycaLWK3K5DVFQSREyZ7URZk6FkdbrSYG6ThuXD7IDydpo3KHS9ujo6rMb4PStUd/y4/R44hNrWz5HpQXMm2dQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by SJ5PPF0529573EF.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::987) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Fri, 29 May
 2026 02:47:47 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%6]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 02:47:47 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Fri, 29 May 2026 11:47:22 +0900
Subject: [PATCH v5 1/7] dt-bindings: pwm: Document Tegra264 controller
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-t264-pwm-v5-1-7bf9e405a96a@nvidia.com>
References: <20260529-t264-pwm-v5-0-7bf9e405a96a@nvidia.com>
In-Reply-To: <20260529-t264-pwm-v5-0-7bf9e405a96a@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Thierry Reding <treding@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.16-dev
X-ClientProxiedBy: TY4P301CA0052.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::15) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|SJ5PPF0529573EF:EE_
X-MS-Office365-Filtering-Correlation-Id: 884f6aec-d708-4964-d129-08debd2caa7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	b6186QInZY2qwriyIZykrGpuZ2oLwtO1QTlsmcAx4paTFJgrZwYGHDQsCwI1jMydtOwhCQt4ZjXiBpPNDD0+n0pJsQ4Hs2ImooMP4Z9EJYhucNejtyGLrj+b/Opk/T8w8d2jKhWNdstgm+OpCH4xmSoYKKa+mAV7uUMW70myq2Lu7fG+2PJ3ac5WcowN84PnzUhOwhwCQrgZEJTzDSTHndwDF4NjqDxPx+dHcU68d0mopEfbYYI4hu2mCKIkBpuZPeAqQ2Ukum0lMlhzu3z5VhISrT6t/h0qks/zE8BX814ZdYT7pz6yCjjEz0+ely+fH7HXs7SaFWKi3PwbdCHbl/MswT92PXDOTFxC3/GJYFxq/8GXIUNGu2LdUBwZf1rYPu8+qDB2z+7HJsT1tC/7ky2UkhFALOZu8WP856z96BOgc+XW5nGm7cYSjXMhaoqIQZ62e6DuORyhg5vZHrxLoEoIr6nxA60bhcCH9i/PlvOFQWiOPZ+nda7f6X1xPBnjfqmFheuQrLcdsNgjO53NJMWJgt0pULfR9yEBTDKfGcrEU5JH5zASVrI4+/mJ1qnVypNBU0EuoiZhm589l2ElpfU/sRQAfbWFZHuH4PJBQPPz0mhPaIQiIr1mlPzwL7EWvUQxyQqO/t6GkdKFJ8raOYIEpRVd4I2XP5paq2srVn3BsC60zmQ760h+CPAvBljZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TFlOWGdtRSt4U0t4UjdJWkZJN0dJWUlFTjdDS21wR0NSNUF1YmxKdzdacUdW?=
 =?utf-8?B?OUpaa0ZabjZHWU1YYVNLby85WGZqc0djYmNYWlVwSVhtb01ZRklNdUl3d3o0?=
 =?utf-8?B?ME5ibFVnTldzVC9jck8vdFgzemRGUk1XbFJ6RjlXM055Vm1XeW5MM0tiSE85?=
 =?utf-8?B?L1Y5SnRJRkF0QzBEVnUzM0h2TE5JeUcyakNRZjQ5MVR4UThTdzZCUnRNUHU4?=
 =?utf-8?B?UW9XaGlhUEhHZHJsWjMrQ281YTB6aTFyY2lacStaUk9wU2ZhdUpybnlZYUJK?=
 =?utf-8?B?bUlRMjlkZTkyblU5MU5WeUhBRDFZVGtuYndEM3JCbTNGckNLZGFva2hCWStm?=
 =?utf-8?B?YU1iSGtraE1IUk1FZ0NZRHZTT25sMTJrZDBVRFNoOE1oYVNub1ZLcGlOajNj?=
 =?utf-8?B?dXFqNjl1ZGhtWG1rWEswWWMvbmpSbU4rQW5ud0pDd29iV2xuS0llek9uOGcx?=
 =?utf-8?B?eC83cGNHTWJOMng4NFVCenY2cmRNcWdwR2k5dEdJaDB2ejRUeWFoa1Q1RWNz?=
 =?utf-8?B?K2hIaVJqZVlsbXU2K0ticlA1UzU2c0VEQ1pKbGs2WTE2Y0JpSStUOVY0TEww?=
 =?utf-8?B?ZFdMdmdGQXFPeWFTOHZGVGJjdlBKRGQzZWhpalhwdkZZR0V0WnJXYVJ5QWJo?=
 =?utf-8?B?ajJycDFwd1ZFc2lDRU5xWE5XWVNSUmdqSmk5aTNLUXdVZW5BV0R1dzJLNjdR?=
 =?utf-8?B?VDdybmttWVpIRGd0ZC9WMEVxYk9qZ21ra0NPeTBMTVUrNnRvZGV1Rjc4elJn?=
 =?utf-8?B?RTZOODl6L25SUFIzVTFjaVZ6Z0NOa3plZVJFRlRYb2c2MXhkUk9aNnZjWlc3?=
 =?utf-8?B?bmJXckpzSU1TbXVVbGNSSW9JY0J4c3ZlbVlta0lkcUNZNnlXVmE2UFB3bmtI?=
 =?utf-8?B?dmwvR2wzUTBSeEUrNk16UG43aUx4U0x1ZkVnM0YwcHVwK3lza1E3R3h4YS9n?=
 =?utf-8?B?VlVHWUxpR2JrYWZpcnVvYnJ6THI3THlTSW5YazBtYTdJYTFzTi81ejl3OWZK?=
 =?utf-8?B?QlVQekovVU9JdG5Oa0plVmZzdnI4SWE1em4yaHpiMUZra0R1ZURteXVsNHBl?=
 =?utf-8?B?OGpqQVdvaXVHeEU3bDZLTnRtQWJJczdHVlpPUHZFMVJFaTJuUVVLTkxGVlA5?=
 =?utf-8?B?aDRBVk1qN1dkYjhLSW4veWlYaVB3OEYrMWU0bkNITE5TVmNLWEp4Vi8rS0Ni?=
 =?utf-8?B?SG56RDJjeGl5eTNlMU5SRnk2R2pvclpUT2FQZS9KVE9jbnBtcmVPcjRsSCs4?=
 =?utf-8?B?TjhVWXNub0htK1VkS2xhTEU2OW82MThKQ3VyV044M293ZU9GVEFTeGsrSS9S?=
 =?utf-8?B?VjNrZ3FwMDhObDFFS1FPeWRMTzkwWno4WnhyZkZFWEQrK0t3cDBWT2lQRDY5?=
 =?utf-8?B?R0NxRDZRNjZTQkc0RllNL245TmFiZ2M4bkN3bnFBcHlPeklmaTBxUmpZZGF6?=
 =?utf-8?B?WEtkVWpmS1UvWTlJYVBtMXFDU1ErYnowSWZxYm8yK0JUQjhlb0k0VFhUWWRp?=
 =?utf-8?B?VFNPQ0gxTDVpUFpCRWR3UkpkYm5MeXB1bU44UUw4cGVLRGZMUjJKZlFNbUcy?=
 =?utf-8?B?b3NreEcwWldURjhwVnBtdisxak9oZFB1S0J4UGNPNWI5VUVnbnNHNTFHSEh0?=
 =?utf-8?B?UlpyZXRKS1VaYjBhQVZjSlJid1pFMm55ZGVzYXRHMDRpREFUaE56K0xYRUx2?=
 =?utf-8?B?Qkh6WC9ESzZONDNQTENoZzkwTHhhWFB2M3JZWUNSYm8vUFpZRGdRUUN5b0Fx?=
 =?utf-8?B?TldyVHBaV3Zkb0ljd3RyYUhjYVRDaEcraUQrVnFjaWxYNkhoQVcrejlscERv?=
 =?utf-8?B?R1RHQlJsN3VOU2FtQXhSUW0wNFhza1VyODIyWXN4WmhtUi9BQ21IeGJjYzBP?=
 =?utf-8?B?Vm8xY1dIb3Qzamo0L0tLeVd3QVI2R0dhRG5iQjlYS2oyQUVZL2gxM3BhVzE5?=
 =?utf-8?B?Z1FqaUp0M010YVE2d2pEY1JZTXQzdTdWNVBDYWt4aTB4VlJwMFh5aTl1ZEhB?=
 =?utf-8?B?TXdNZVVPaUYrUmtkeG05ZHllZ3lWUlVmVzRBMXMwR1dSa1lveFdOejhpQmtC?=
 =?utf-8?B?NUltQU9neCtJUnpmUXF5RVMyZ0V2MEVxTGswNlBVZThXeXpWZHI2SEh3SmVO?=
 =?utf-8?B?cWJ2RlZxbXNGaFlZM2k3WjduTzdrZGR3Qi9LTWd1Q1hhOWhjSHNBR0lOaXA5?=
 =?utf-8?B?T1dFNUtPOGhqS1I0OG80Nms0SWRLU1Yyc0ZSeG0zaE1XOHBRZkkra1o0S3p0?=
 =?utf-8?B?NklVT29XMFYvMWxIRWd4R2NlKzExeUJ0aWRFZ3lueERkWDgrMzJnYmU4bTZr?=
 =?utf-8?B?QStGcytpUlhaVWRYLzhYejdPc0lCY2kxT1dBREpIc2M3VDhvZWhQNFBOQldt?=
 =?utf-8?Q?FwLU3RgPR11a2I7yAReQIMpM65ZmGwXUuusrzY1HIZLal?=
X-MS-Exchange-AntiSpam-MessageData-1: 7tajq/WQXFCzzQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 884f6aec-d708-4964-d129-08debd2caa7e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 02:47:47.0753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xuca2fA6mD8n54R8F5J8VAZDi3BsMcmjbMsE3STOtEZQbOt7lgFnXdqTl39xhnHvzE1yICaPsIZsUnGINzXOAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0529573EF
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-9192-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 83A3F5FC7FD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Thierry Reding <treding@nvidia.com>

Add a new compatible string for the PWM controller found on Tegra264.
The controller is similar to earlier generations but not compatible
with them.

Signed-off-by: Thierry Reding <treding@nvidia.com>
[mperttunen: Drop extra Tegra194 compatible string]
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
index 41cea4979132..cb2f36e7b5d6 100644
--- a/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/nvidia,tegra20-pwm.yaml
@@ -16,6 +16,7 @@ properties:
       - enum:
           - nvidia,tegra20-pwm
           - nvidia,tegra186-pwm
+          - nvidia,tegra264-pwm
 
       - items:
           - enum:

-- 
2.53.0


