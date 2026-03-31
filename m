Return-Path: <linux-pwm+bounces-8430-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2N+iBJkty2n8EQYAu9opvQ
	(envelope-from <linux-pwm+bounces-8430-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 04:12:41 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E36A1363553
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 04:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43E863018F34
	for <lists+linux-pwm@lfdr.de>; Tue, 31 Mar 2026 02:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950DF367F58;
	Tue, 31 Mar 2026 02:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="eU4eEqjG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E7A36680E;
	Tue, 31 Mar 2026 02:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774923159; cv=fail; b=bCrLsF9fJizcdvZkf75VL0bdmrvOmNfuRJ2xv6/MgSSZdtLlz5GQDnqaIH8O+rOixs/eq9f7mjOqorj2HWzjpf1t+wS/6NmPI8GcLzJsBAhjJc/wAILmpNZq/r5pIottl5yLxnTPKoqaKW6tPHcboUSddjkY9Q+VZEZktd0V1vU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774923159; c=relaxed/simple;
	bh=leTbcj4FMLcK9z9PHJTEcwIoKBcs5rLbh6e3rbxL0Hc=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=s6Tkb0gtq0nLrTIOZlUFL2j01drAVs/k6kbkyKFsGlSgW5QpoPKja0ma8hs8wxtLVvtuezC1pZzh5fgTIYlVvDZeNX8WHvSr+H77lLnUAYjmt4MYalJUtKpb5Pk+XE9u9ZZRnws+kf/35eBemXBZtd2mPCFjPbwxQhhLL3TyCqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=eU4eEqjG; arc=fail smtp.client-ip=52.101.43.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=waAvgPxMQYKj8Bjs0OB4sDNP884CtQgtSNmverYf7oJDSyJUHEwcCOgvVP1FTug6Vmc9h97NnpwhpKCKFy64XMRdYXhSSq+f6mM6/zm+ItxL6hnq7yOfVZEATwq9HylGx+TRbqjwpZlnUc0MBGrtZBoB4UOj1huOcbOXUGP8IMqT6Cx0QReFX+xarV/sNWL3G+2yOx40a0OlSjxzenIhgmgofACLZT3oEVMQgxeQSp0BTFQFi3/QbC0kFDV1FkBbcHvhOrAZsjMOt8/kGTP9fJOHLmcaubTpAtkA9ncaEMs3ZaNkuG5ngk1YKftyi2I6q5M9wg1Bn5fc8QKoSAArkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37uCpLWqPlXVN7F/G1DOY8UA28+L+hols+4SBM4yLh8=;
 b=qW22utyzaOf93ZaHE/ncnTSAx9R9/2GDQl7cD8FXNvJDC/WAiXIue2KZdcY7/d41gfCpC+jQYqRDrGNX5+3HayTRqKBhfKTVgfh7LVMNj9tR3lyBl29tjS/T6pY3d0Vx/d+22L3hlsLISitpJP+BbME1bcIhy2domqFiGAAdtsTY5pL10CNA2whfajvLan1Q3MbohLsK9/CMP/LuLcFCRtScvwQ9K8RlYk3fy1ITPbK4JlLdNFUWpe9VO9D4k7eopYpYc+pcy51aY+NEJz4UCf0IG6wG0FAI6aMh7jw6QXs0IKZyIDsWvWtBODrHOdskMXgDyskw5Bmjr44Ug6mIxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37uCpLWqPlXVN7F/G1DOY8UA28+L+hols+4SBM4yLh8=;
 b=eU4eEqjG6WIH2nDfRkpKy17FtJEjZBRdGOjN7zaauV8+UguQSZQz2WCgTaaVCUiCRxLFkMG/7R+UTsvMrZlQKJvOW56ik9sD4xqVTDGkmaSN5oNjJ4plfzI7staTFivxarYRN84tnbzYbkgKV8RMuTyp88HM4wJ6RsYbJXthuGg2loV2/87x5pNUbsXZXXJbYg4lwf7W/L5JKFfC1jxNjmqIvloarQ8gH8hdbDtou87aNhDs5KhdVgQTDNMpiJ5zRxeOpqUn0BUXW68Bxhjn4EXDE3jBQPuipM6pRxKDFmvfgePU6Jz5cXp/Pq9qwvUPvvSL8TQGX2mP77YZDfhNlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CH3PR12MB8330.namprd12.prod.outlook.com (2603:10b6:610:12c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 02:12:30 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 02:12:30 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v4 0/7] Tegra264 PWM support
Date: Tue, 31 Mar 2026 11:12:12 +0900
Message-Id: <20260331-t264-pwm-v4-0-c041659677cf@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XMTQ6CMBCG4auQrq2Z/lHqynsYF0hbmYVAWlI1h
 LtbiIsal99knnch0QV0kZyqhQSXMOI45CEPFen6drg7ijZvwoHXIEDQmdeSTs8HVdoxsCCM9Yz
 k9yk4j689dbnm3WOcx/Dey4lt12+EF5HEKFDZSe+1FKDAn4eEFttjNz7IVkm8lKqQPEtjGts0y
 jTyJv6kKKSAQooslWZScm2V0fWPXNf1A3G1+WIVAQAA
X-Change-ID: 20260303-t264-pwm-57e10d039df1
To: Thierry Reding <thierry.reding@gmail.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Thierry Reding <treding@nvidia.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, Yi-Wei Wang <yiweiw@nvidia.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: TYWP286CA0029.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::17) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CH3PR12MB8330:EE_
X-MS-Office365-Filtering-Correlation-Id: 49ce0acc-0219-4388-c879-08de8ecaf653
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wfb+rzQf+gBSJBvoXnR6nRbEfpsLsqYy4VVoPvdSJAGmxBVWx9vlpZdbwHRwJKdkZgToYRfU5s4KOUdYrozqBV9IX3h/4pKw5mikBhYbURnZmQeee1q2w94GHIOi78VQ8/IJHHMEfPfwwS/0JbcsKfhtdgpn2CD03yjuyUDPGgi3B/3yyxlhlkSIk6I76egmPZExGMVn7FIDH8ZJn0fD1PlZDxAT6H00KA7BgNsJJgV4aiHw1oHz+YSupaYGOzBQ7p2ZLG7QngbYHX16N6OQ+hkATB0YTOGMdedLXsDnzY6EbCw1RmUJi92afebYZR2AMEde2I1aFuvlJZzjHoyrN/Xqs5171nu6bPqUFHIhxyQD1CvIYSrh4QlbZwE0Ljeu1Dy/FPRk0h08rU7Zjjt8auD4V98zdVzwynqZUNXlq+/fNLFV1pmVPoEALSZYXyUI/RdCaxclaaXJX6sPDFRY8KEGrQHj5DiCWyBzUguZkDIXQrhaujOhB0VNJzv61Kgb6Bwt/GdWDLSwsW8sG40QXGs6aIEFmBOPoWGZYMSumTufLNtyiXQtK4CKsrHqrUyQlk38HGJZYkKItA1XO4/ziDu2drmmSFN+2nxP3aPh36xq3i4lHV/lLjixE0Q8dCfNwE9XzmRMpQ+T4PY/NP+M9Cu+zI0uwnl+uTV677WdvNW6hheKFzzHi4rdXku87B1hcaCmXoRybZnP0uE8ioZjigrvbzi+4Qc3izyHoD9dYgc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB9161.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzd0UFArd21qWk9UWjEydXB1d2JHWTJJN3Vob0twbkNrekt3UjB6ZUNtLzlk?=
 =?utf-8?B?SndBN0QxRUpIOS9mVHlIZkFqWUxVMHNURHFNUWN6QTAvKzJUV2dxRWNwRk9v?=
 =?utf-8?B?TXBkcnlvUnREa0lPbytIaUxmN2o1OEx5dDJwTS9rVXM0ZHl3dEhReE9mamF5?=
 =?utf-8?B?RlVjVmErZ0tLTmFpN3hZYmk4ZC8xRVdJZEdHS1M0RTMvaVpScHBnSytOYVhU?=
 =?utf-8?B?RTg0c21VcEZ0ODFId0o4dWhmd1Nnemh1Q1djNGc2U283Z09WWVlBM2hvNWJX?=
 =?utf-8?B?citEVnFhaG5CejJJcXFVcjBKYUdSU21QZjlJN1lrUDA1a01mSVo0S0ZrRUJF?=
 =?utf-8?B?bHVBVno0NmwwRURCbzAzSmhoWFBCYjQ4UW9pbDdYUE5xdHRUU0p2Wnp6SHds?=
 =?utf-8?B?RDA0OVQ5N2ZYaWRSOHdWUllKMmpaR0tUSTVzVnY1c1gzZjdsbUllM1I0VWV4?=
 =?utf-8?B?ekt6cCsrYlppWlJjVm9temxVakRMaDJnaEYzeFIwemxBdkxHaU9xejNPZUxp?=
 =?utf-8?B?TjJ5Y2lmMXNNYXdiVSt4OHhZaG0yekgzaCticGh0aFJwYkdiZ2VWdnlTeUg5?=
 =?utf-8?B?K3pqTTNzOUJ0VEo1cEdaL1pNYkRVWHc3Q0k4YitzQU9zdzhDNGZMUlJKZE1y?=
 =?utf-8?B?WmlMZG9KSG51eWlVZUpkbDY1dXNVbkJ4MHNqS3pIbHpVSXRpTTZsOFNQaXlp?=
 =?utf-8?B?Y2FDQWd0S0VvWkxNVTI5NG55L2ZlZFNrTVJ5SmExRFRLMGJadmdOR1RQMFBZ?=
 =?utf-8?B?NG0vL2ZvUnpCQ2wzM3FIckpOeVlSVnczQmdrOUxicy9vdnIvTXpZMmltNFJh?=
 =?utf-8?B?a3RoTjRlM3VsT0ZUQk15Z0NBR0xieG1uVnZ2MWdscllIMEMrcE9ldm04dHpp?=
 =?utf-8?B?ckV6KzZvNThTdjZDZHlkVVREaUhEWlRYRWdjUHdJa0d4ZEptTUhIZHNwRldK?=
 =?utf-8?B?TjVJL1V1cHlnanc2ZnljcEk1TDM5dmZUWVg1RXp0NHM2MjZmczNFb3Z6US9r?=
 =?utf-8?B?TWlzNHVNd1JvUXM3bVJWdTJqeGJ3SVRNc0x2elloSU5SY3VZbyt6VmEvQlc1?=
 =?utf-8?B?NEV3aVVZaHpsSy95SWJyaHFFcFFJeTErazZ2d0x0cTY1dzhDakJnSUdvZjRv?=
 =?utf-8?B?NlZERWlXRGJBQ09zaHVnTVRKVkxZb0drQ0lXVlU4NlVaNzB0czVtcklMekVS?=
 =?utf-8?B?L1VLaG5QdjhMM3NiQyt4WUZFSWpJVzkxa3NrMXJvMGRmTVJVWUpaSGRBbVFI?=
 =?utf-8?B?SnVJeXlEaWY0ZmhVMi92UFJtcldLVUl6UW5wRWNiU1FmM0d5RUwzTzdnUitD?=
 =?utf-8?B?elhoSGxJVGdkY3ltejFwdzNLaTBVYzBLcXBJOEozYmxJMTNUOGd3MXBkWkdx?=
 =?utf-8?B?ZGdUZ2tZMDZISzBmbXpjalRPelplRnZmMVBpZC9KUkpReFhyaW9sTXZOY1dm?=
 =?utf-8?B?Y1BXek1IZ1I5eEZKdUhZTE1VMHBHb2xwTDRqeFBKcEYxY1l2b3pGNUJ1NXZo?=
 =?utf-8?B?M2I1WkwvWWpVdlQ1WjJRcUZ5Z3lqc1JvUzdYQUhqeDBkcU9nUmRJMzFXeVY4?=
 =?utf-8?B?MEZybjIxVVF1TnRRdzdqaVJSckI1Y2kyVTBJbW4vSWlEeDR1S1RRUjFiMzBx?=
 =?utf-8?B?T2ZRL0U0YnZna1B0WXFzZytlUGp3TVV6dzA4SWRxOGZINUFqYnZtdXZiRStQ?=
 =?utf-8?B?R1BKNCsyRjRJVDNrV0FkNEp3c25CWXdlL2JpcEJOOE1obUdNbHFmNkV6UU80?=
 =?utf-8?B?SU9UUEZ2OXQ3RlNqV1dnZVFWbS9nVWMrYldMNWx4NEdPUnN2U3JiWEQxdVdK?=
 =?utf-8?B?UVFoZE1VNmJpempLaTNaN0lGSmMxZXNTeEtIZGlOL1RmbjRpSlhoRWV2ZytF?=
 =?utf-8?B?UmQzcHM5U3I1U3ZrYmhOWDVJejVnOWwzalBLU3QySzRNRmFOMXZZaDdHcnhY?=
 =?utf-8?B?MUlHQS91aHh3d0xwUE1vbGpHRWtpR2tjMlA2ZmpXSVBRTFdVNG1LQkVEWkxh?=
 =?utf-8?B?Yk1CaHMrM0hTSVhzWjhqSXdLSmgwdGVOL2FHK3RIMFY3MENkWTA5ZEZ2Wm5S?=
 =?utf-8?B?OURCdnVoOGlVQkIwZjhGTUtmZVZiUWNnMk1IWER0MEFCakE5eDBGWmVQdHQ3?=
 =?utf-8?B?OFlNTjZ3WWJGYkpTalNCNVpkKzBLTG11ZVBDWm96eWNsOU4ySi9QVFZpRFJa?=
 =?utf-8?B?bVZSNkhEZUs3VEE3cmQ2c0ZkSTBLTC9MbG50MzMrSDdlTUIzTkRxeWFUQkpp?=
 =?utf-8?B?WDAxaENpV3RYRWNITFRVNU50MmVGSzhqL2hvcGlFWFRaMVFCcjRaUjRMTW9w?=
 =?utf-8?B?MDl3eDhPaUpqWkQ5QWNFUHZmZjRUdmp0OGx5cyt1RGJreU5zV0RTYWt2ZUJh?=
 =?utf-8?Q?cRrYK2OvOlClKEqPUm7fA0WCQs7t5q5+MBt/TItGK1/zk?=
X-MS-Exchange-AntiSpam-MessageData-1: wmUOuF/cOYpckA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ce0acc-0219-4388-c879-08de8ecaf653
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 02:12:30.2182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EUgf+WHxLPT2eVesHYU5nqG6nSrvudP+/5OYhgT2+yOOm8lkBfb/DNM1npQydNBBhLovdlsANWw+uY1Jh1UUYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8330
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-8430-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E36A1363553
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

this adds support for the PWM controller on Tegra264. The controller
is similar to previous generations, but the register fields are
widened, the depth is made configurable, and the enable bit moves
to a different spot.

This series adds only basic support with fixed depth -- configurable
depth will come later.

Patch 1 adds device tree bindings for Tegra264 PWM (compatible
  string).

Patches 2 to 6 contain the PWM driver changes.

Patch 7 adds device tree nodes for the PWM controllers on Tegra264.

Thanks,
Mikko

---
Changes in v4:
- Use ULONG_MAX rather than S64_MAX to avoid overflow on 32-bit platforms
- Link to v3: https://lore.kernel.org/r/20260330-t264-pwm-v3-0-5714427d5976@nvidia.com

Changes in v3:
- Fixed device tree binding patch.
- Picked up trailers.
- Link to v2: https://lore.kernel.org/r/20260325-t264-pwm-v2-0-998d885984b3@nvidia.com

Changes in v2:
- Added device tree binding and Tegra264 device tree patches by Thierry.
- Link to v1: https://lore.kernel.org/r/20260323-t264-pwm-v1-0-4c4ff743050f@nvidia.com

---
Mikko Perttunen (4):
      pwm: tegra: Modify read/write accessors for multi-register channel
      pwm: tegra: Parametrize enable register offset
      pwm: tegra: Parametrize duty and scale field widths
      pwm: tegra: Add support for Tegra264

Thierry Reding (2):
      dt-bindings: pwm: Document Tegra264 controller
      arm64: tegra: Add PWM controllers on Tegra264

Yi-Wei Wang (1):
      pwm: tegra: Avoid hard-coded max clock frequency

 .../bindings/pwm/nvidia,tegra20-pwm.yaml           |   1 +
 arch/arm64/boot/dts/nvidia/tegra264.dtsi           |  72 +++++++++++
 drivers/pwm/pwm-tegra.c                            | 141 ++++++++++++++-------
 3 files changed, 171 insertions(+), 43 deletions(-)
---
base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
change-id: 20260303-t264-pwm-57e10d039df1


