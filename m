Return-Path: <linux-pwm+bounces-8360-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFc1JiW6w2nUtgQAu9opvQ
	(envelope-from <linux-pwm+bounces-8360-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 11:34:13 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 169533230F2
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 11:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A803230160DF
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 10:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96563B6341;
	Wed, 25 Mar 2026 10:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kHcaa/N6"
X-Original-To: linux-pwm@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011033.outbound.protection.outlook.com [40.93.194.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B1E3B6340;
	Wed, 25 Mar 2026 10:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433878; cv=fail; b=K1G6QpnHX/0eVDYW6GndY1gj4AJ1uMAOZnOi6iszofaqoC0r+obdGXDAZUEdnrUK4+kcHAoQsq8kUIGYNDiX/T5GfOJPyC3xL4J9J6rKHQoDJYSZDkwRvlpqACyZmuIFhUzv3W0tWqa0aeP9cDc7uwBfNLOKx8Ic/0ZPvH+Cfbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433878; c=relaxed/simple;
	bh=ucV7O3uQ88HeCUavFZaczBpruvo2XmgQ0OjBCZ3wa2E=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=nMCjKWfVZeM8CFR6P+2psI905b8aUfvHwjS4befALRUM7le7OLqno6UKEv9/qGO+zn/qOv6XSK5eT/HCnywu9Rp+olqjJGYmxLLjL3nwLoAztMxYmcqXQ8iztf1GnTz2GsB3X7G8VKcsbDqmTVBNJWxDU2MLVxf6qrNVaSy7k5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kHcaa/N6; arc=fail smtp.client-ip=40.93.194.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oozjPggdy4YFxcMNSnN8pcaFYcu3RHrOMhKGGL4x8hDWzBJJr4AxEKNrfZdu2yXCv4PwmLAxDCalzgWTG5gAAy0he4loi7+f1ZzloGOtB96/86g5fMV7rBugTIRel/Hx+QHnX5e+7I7P20nIzNRGnIVayM//BIV3Dc2Vg1i5CIcfj8SPYLrVtZcOIZ42PViyaxJ7bKu6qGO8NeMDhnZuJBAsIV8424meLTR9g6pvUZ+Yr8CrVnvP7RUGCjZcglVcH+KWpYK4RkycJ1PQWPa9mQfY5PCVgDYH7/MQW2A6gAs7xGbNb8/GSqoKmxL5WQLRFsKtKOl7XMXNMFU/FNEhNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yg808l5jGFqdOjNqiqmM6dwsAJWgRw49wD8NvoOW2PQ=;
 b=zBsht+9LnlXnSBofz6Crgyw/MiqxTvxZzggh5J1qW4rvdpxcNCQKHaGzvHSHvl/TagnII1WtWGNJO5YHu/oUHtj7iisEbIkhMx0NHq2TKD55qrIFl8Nsab0lK22alz38iAhtRgCvsKRbsCe69WfGmiG6kShvaN1H12rmCjamafXh201pIbcFeQZkFBXHL1twfhFHpYOrpTFqK42GJG9ptfyloUtMOd9Ht/6Rdt2CNkhZlnYVOuqFAr8MYWs4FmtEk6LGUAqP1ZCoPH6KIK1QObFb0C4cwFBZFWdoo7BBkDpr5OnIs+UiW/BJrWopvd/WZcVCtyxXOIj4nuCNLheuqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yg808l5jGFqdOjNqiqmM6dwsAJWgRw49wD8NvoOW2PQ=;
 b=kHcaa/N6K0qjlZZwB/fiv6LNegxaQefq1mFwGoJUjQwwMwNINoJ5AiTgVXIvoPi4QnLY3nODiAx6sO3oDQuXR9yuUUqzMImoIknf8QJtoVAhDxB6MXBCkg5ulpliXH5JpjRHsj1reUmK8dNcSB2eoDzaVmUuhKFQdC8NCx5yxL88FSXPWYGmWQKxsJxMZkrUtv48VPqoZi7JdtT0B9S/1csPyshOlKn8WR62ySh8tJe6BCHOcCmKXSTV+V2MLDwEzoQJkwp/4JUZkO8PbvL9Rxi1eiAMLaHJCbqeb4vBwrqFPzsya7D1yqYZHk1F5lPgll0wNtVxJDtplwXNsQbsVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS5PPFA3734E4BA.namprd12.prod.outlook.com (2603:10b6:f:fc00::65c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 10:17:51 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 10:17:51 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Date: Wed, 25 Mar 2026 19:17:01 +0900
Subject: [PATCH v2 3/7] pwm: tegra: Modify read/write accessors for
 multi-register channel
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-t264-pwm-v2-3-998d885984b3@nvidia.com>
References: <20260325-t264-pwm-v2-0-998d885984b3@nvidia.com>
In-Reply-To: <20260325-t264-pwm-v2-0-998d885984b3@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Mikko Perttunen <mperttunen@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TPYP295CA0057.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:8::8)
 To SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS5PPFA3734E4BA:EE_
X-MS-Office365-Filtering-Correlation-Id: ed7d31c6-8bbc-41e4-9dcc-08de8a57c579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|10070799003|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1MEhCbOL+p/dW59DEfKHvhe36fTgrpI4XngZpChpyzyJS0/1jSMiVmGHD2LvnoaLNAtDLUloKEJrfqXNXLj6VFczPZApzthqtNfJJ7ri6t+OzXYGaQU42GcaH4SvALAeaMQVk7PxOGIiDXYyLgGVADlaA7BlCE3FGZcxOAeW10VRAAsimjcjO4BPebHKvHorvyBkh5bHtKP+kqqVRc3jxxXeWD9FKWymM65lbwFd5DApHKtRmzpxrwm4jO1PZpR8R3zlId/E89dH+IJynYy6HBXP0CH3XVxsrhENdZcbCyIMYdbKdnf6q1fGv3ABk8uhz/PN1hdpAZeVZStBAtAs8hYYxxPzuIsRflj4C9nyUMMiPJxOmLoBXJCSoJ6Wcs/mC+3FnMGe+50C5YmhPEDJr3ObX6vqPwVWHa80ojdCGkZfzL6yOAUGQ0JfsTYKeutzqkOqPACqh9igyc+UL6w7mnOk4K8uMXYMaXqsk1g88NXuw9O9Xh4LR8+xZ3w/ff107TQfu4nVxbEPsQdeK+PZs+RqtJpJf0FbGGrO4lbDFPoQzoAFP32qyQ+rlnl+HIFuoMJY4wjScS3agEWMkUbQlHr5LELLWbzj24gKUr/TzZsyjUJrJBW6KrlB7LMBDG+KQvx4FOIBqflksAuplNkYUNy7QJf9KJmClA0a09gnGxidSqQR2GmUjbM1AyS3C2gbxm9bo8u7Ts1w74/0BeOfxPuuRYMkJqF8EyZgmURRSB0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MmZpL1BSL21wWnpXL0dtb25xNWR2clBxc0JJZFE4QW1sNnZiaTg5Sjdjc3dV?=
 =?utf-8?B?aG9BRE9rU25xN3BPRGF0Y1ZMbjJHUzYycTlQNkw2a0hzVE9YbFF5Snc0R0lx?=
 =?utf-8?B?VDVLM1I2ZzVERU5FUmpBRmxZMkFIV0kvU05jMmFpZWo2WkFUVkVKTS9YSi9Z?=
 =?utf-8?B?Z3ozbXMrN1NpTTV3cXJzdWJSTUROaVBuWWlvZitMcE5yb0RFWHppVlZrMzlw?=
 =?utf-8?B?VExwdkJnaTRtZy95N1oybE1hL3NHRmhVRkdjR2dLaEp4QWg3aVE4SVVLMldY?=
 =?utf-8?B?R1hKblNkTlBpUW54dm0xVHQrS3A5UGpRUndtLzVtTFc5NU11YjAyQS9LVjJK?=
 =?utf-8?B?L0pyL0xZTkw0UTMrdG03am1VTXVJNDAzZnB4dUFweW9SSk1kczV2VGNxQmJ3?=
 =?utf-8?B?VHQvZDdNd2hmanV6dDF5bW9ZcEF4YXAza1cwalROM1o1Ri9kM0YyVEtKdzd2?=
 =?utf-8?B?VW4xNVlKUGJpdTZ0blR2OFBhTGk3RkdIQmlxYXFZdWFaazkvb2t2d21DOW5l?=
 =?utf-8?B?Q0dFVW4wT0dPWEdIR3FQMzU5ZkRRdzZSaHFvVTdMZVJKcDN5Q3pSb29rcm9p?=
 =?utf-8?B?eU1NRm9GQ3hnUGFuOXVWczRTWjhtaU5uQ1BqenMxSGxwN1dSZUwrNkVBODFz?=
 =?utf-8?B?T0Y1QSs2M1lxUHF6MUZqcHV5VHUybmVWeU5LSkx5czZFbFcrRkxUUGt6ckdl?=
 =?utf-8?B?QlBXak9RZVNlbHdQWVV5VFdUYmlYM0VNWkg2dklndVdIV1lJTUJQZ0FTRTcv?=
 =?utf-8?B?ck5kc3I2aTJ1bVY2aVExZW8rT0tJbGRCNG5ET3lUVi9jLzdGeXhkRFM5Tkwr?=
 =?utf-8?B?dERId2RoVzBNTkRtQ1dwbXRWeTVzbmdDRXRXSFVjRTEwL1VtbEpNS2JjOVdH?=
 =?utf-8?B?bnFGcWZwdXRJZDhJa3RBaHUyME9UTnNaN2RoNXRHZ0luYmt1eDZ5Z2hBR2Rt?=
 =?utf-8?B?THJFWGNOUmREb2JFckVxamtlUnh4bnJVQWsxTCt2NnNCWERPd3FuMU5ZOTA2?=
 =?utf-8?B?eHJnWlJMaHFIdnBNVVRPcjZZWURqbSs1ZzBRZE9aK1FRdnV6aDFlZXc5QmlI?=
 =?utf-8?B?YTFpRU9rQng4azhBdzJudXJQSXFJdS9MeUg5VWY0MmJ6TWZ4WmlpaXRLVWU5?=
 =?utf-8?B?aXhKZjNtanJGdVNtRkFqUUJSZXNJdVBUZGRuMHQ1ZHMrc1ErVFZ2VEh1V0ZQ?=
 =?utf-8?B?L2EzQzlVOWdqcVZYMlRuVW00Y3V4NVFuYkdZK3p5dm9HbSszL2hTWnRZbmNj?=
 =?utf-8?B?eDU4dlJFd2kvREFJOFkrSkh5a04vL2VUMWt5dTlkME9Rd29CREVRdEdYTWp2?=
 =?utf-8?B?VlNJeTVpNDZBZ2xHZU4vTnJLSmFjRDNpWEFjMFI4N1lVc1ZBU3o5RVVmSEYr?=
 =?utf-8?B?UjhWRWRLMEJXNHNGSlZtR2srTzE5U1QzaElzT0pjNm81NjV6SDRmU01nZ1lS?=
 =?utf-8?B?ZXRZbmgzRXpTRlhtT1pTZHJqclU5c3hFcEg4Wm5VNjN5U280ZGkzUWRuNWlj?=
 =?utf-8?B?OWxkam5ZTTFWMDZZV0hCMTNOckpJVzJsK0oxaVlTSmZlcWVTQWk5ZVhIcmRx?=
 =?utf-8?B?RDNWQnJwc1BweHcwbC9OQ3NaWlN1aXNUcDJzakFZYnY1R0JYREt1NHJjQklr?=
 =?utf-8?B?aXVmZExrVkZIUWNNQk9XR2wxUXBWb3pramZCNGlzWjRDMEtCVVRkTmI0NUFL?=
 =?utf-8?B?TEFDM0d3Y2pDOFpMdnBVVWhlQzl0WEx3MkpWS1loNGFTQjF3RGx4M1pNYlNu?=
 =?utf-8?B?Yjh1N3g2S0NqWTl3a29jOGFXYTg2LzJ2YkVLb2l5YUxwOHY1YU5vV2JFenZP?=
 =?utf-8?B?K0tBREZIYUNNYlFQa1ZSNEJWcThHUExhaG16R1VQQ1BCQVFzejV6WFl4VWZD?=
 =?utf-8?B?Q0NsbHFUZXZMeU9LbXhIY1lsMVB2M2ZobllLVWJJLzdpcGVjUUt5YUtvZ0lp?=
 =?utf-8?B?UitTb2hGWXdFV2llK01aL3dQU1dhWUJjY0REUGc0MUJPWkh2SFdwY2FYK1gw?=
 =?utf-8?B?NGpHS2VzQ3RxMHNqV3dxWVNxSi9FcitTc056b05qeWR2VW5GLzE5WFlwa25h?=
 =?utf-8?B?Ym5QcnZUSlVLOEZub0VRemZVM01PRFh4OE1ySk13NDZzRXFBRVVObVg1MTRC?=
 =?utf-8?B?NzNMSHMyQ2wzQVF5dzh6aVFleE1aWVNtZkhiVnJFa2daZzE3UjhEY3VFby9k?=
 =?utf-8?B?RjArZGpvR3JqODNNMGp4amkzZDl6NllEN3BkUW15d2o3UldMdHdYay90aE15?=
 =?utf-8?B?RUZoUzlGRGZBSlRxSDV0QmQvUE1NVWprS2NiS21ucGFCbGFDZHAwbFI1dTNN?=
 =?utf-8?B?ZHh5VzhHUHhRdjNkcjFuVTBPc09SUUcyZjVqa1FibVJmWlRKckNubm5EZmtH?=
 =?utf-8?Q?adbdEYBbGntkPDRvZPm41ZtDaSHZwGzC1uDF497Mw3cQS?=
X-MS-Exchange-AntiSpam-MessageData-1: 6t1GR5+iC/l2Ow==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed7d31c6-8bbc-41e4-9dcc-08de8a57c579
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 10:17:51.5168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGXs1R1ueaNDk4y7k3NxEjQzQHXrqg9k4eajKG/MOo83SDoHJzAaOnzU5uTfyRLyy8Y23h+xi8eBid16cwoPzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFA3734E4BA
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8360-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,nvidia.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mperttunen@nvidia.com,linux-pwm@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email,nvidia.com:mid]
X-Rspamd-Queue-Id: 169533230F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tegra264, each PWM instance has two registers (per channel, of which
there is one). Update the pwm_readl/pwm_writel helper functions to
take channel (as struct pwm_device *) and offset separately.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/pwm/pwm-tegra.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 759b98b97b6e..cf54f75d92a5 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -57,6 +57,8 @@
 #define PWM_SCALE_WIDTH	13
 #define PWM_SCALE_SHIFT	0
 
+#define PWM_CSR_0	0
+
 struct tegra_pwm_soc {
 	unsigned int num_channels;
 };
@@ -78,14 +80,18 @@ static inline struct tegra_pwm_chip *to_tegra_pwm_chip(struct pwm_chip *chip)
 	return pwmchip_get_drvdata(chip);
 }
 
-static inline u32 pwm_readl(struct tegra_pwm_chip *pc, unsigned int offset)
+static inline u32 pwm_readl(struct pwm_device *dev, unsigned int offset)
 {
-	return readl(pc->regs + (offset << 4));
+	struct tegra_pwm_chip *chip = to_tegra_pwm_chip(dev->chip);
+
+	return readl(chip->regs + (dev->hwpwm * 16) + offset);
 }
 
-static inline void pwm_writel(struct tegra_pwm_chip *pc, unsigned int offset, u32 value)
+static inline void pwm_writel(struct pwm_device *dev, unsigned int offset, u32 value)
 {
-	writel(value, pc->regs + (offset << 4));
+	struct tegra_pwm_chip *chip = to_tegra_pwm_chip(dev->chip);
+
+	writel(value, chip->regs + (dev->hwpwm * 16) + offset);
 }
 
 static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
@@ -194,7 +200,7 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 	} else
 		val |= PWM_ENABLE;
 
-	pwm_writel(pc, pwm->hwpwm, val);
+	pwm_writel(pwm, PWM_CSR_0, val);
 
 	/*
 	 * If the PWM is not enabled, turn the clock off again to save power.
@@ -207,7 +213,6 @@ static int tegra_pwm_config(struct pwm_chip *chip, struct pwm_device *pwm,
 
 static int tegra_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 	int rc = 0;
 	u32 val;
 
@@ -215,21 +220,20 @@ static int tegra_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	if (rc)
 		return rc;
 
-	val = pwm_readl(pc, pwm->hwpwm);
+	val = pwm_readl(pwm, PWM_CSR_0);
 	val |= PWM_ENABLE;
-	pwm_writel(pc, pwm->hwpwm, val);
+	pwm_writel(pwm, PWM_CSR_0, val);
 
 	return 0;
 }
 
 static void tegra_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 {
-	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
 	u32 val;
 
-	val = pwm_readl(pc, pwm->hwpwm);
+	val = pwm_readl(pwm, PWM_CSR_0);
 	val &= ~PWM_ENABLE;
-	pwm_writel(pc, pwm->hwpwm, val);
+	pwm_writel(pwm, PWM_CSR_0, val);
 
 	pm_runtime_put_sync(pwmchip_parent(chip));
 }

-- 
2.53.0


