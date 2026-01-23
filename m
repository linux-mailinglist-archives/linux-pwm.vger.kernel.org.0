Return-Path: <linux-pwm+bounces-7998-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHphKHGNc2l0xAAAu9opvQ
	(envelope-from <linux-pwm+bounces-7998-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Jan 2026 16:02:09 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A83A7776A4
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Jan 2026 16:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C24B1306C9FF
	for <lists+linux-pwm@lfdr.de>; Fri, 23 Jan 2026 14:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA0030EF91;
	Fri, 23 Jan 2026 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mWasIRiZ"
X-Original-To: linux-pwm@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E1B3358B9;
	Fri, 23 Jan 2026 14:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769180356; cv=fail; b=paiIbGOS4ongSJqQgL6Io0mHLSAeQl+hdDNc8GDNM46UMdoSoo/FvIs2XsO+j/Ib/KbqNjog5pERY9MTTMZRPsj05mCYJtGsrRuo9/kz4ObTlXcQvjZsF+qupUPGMSwb2ccCBIZsbwq8xAe/+X6s/X+3EHSBiw4gHx4FqJKWF/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769180356; c=relaxed/simple;
	bh=+gNKWqV9xlQ3eoiRk3WQQOOKUN2l9wCmgPspE/T0Tco=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p4ZXR8mBFUdRsKVgANPgqeQAMl8HQeIxs+70CGEZenUvtV04IhX6cm6yWbYjweT86il22+LVh0r7qxgewGvHlJd9BYaXA6KpJ/5jHdMJhgn/QmXqANJIKEE6VLKy4BBZql4LLqUHm0To8f2us8Y1nvALFfu/zDcB7qqMMHkbcP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mWasIRiZ; arc=fail smtp.client-ip=52.101.43.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cRh0JuIDCARxXQvabTn7YmSmJQ57W11u/HpHFW3rBT0mY7mpU/Oef/HfledR6oaHBMgV/uMsqWbqqGV+6IQqIMVUJYcUoFEAQNw4NsMBwiz/nImn6Lv/ctMvZkTF+d8+Lp1Lwhg1p/PNZOj30nqH+ZJ7ftjUa2/UCJd+F4StCQyTVo3OWgw2hQSeabT3HUU+Zgfx1ViTqFKfYNZJvSXr0DgTeJdmkPKHilQquaD/CeBNX5LfW6JXhlqWcYyrdKuhNv2Gc7AWR2B4mWV3Ecm8RYdh6ya28EuvAzO+wornYxEmsnvmbvjBpjUg4PXTFNV6Wf6NiJog0jhPQR0Z8lQ/ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=726ONQ0tLrhuCsaHakiNV6jaiJz0PhpPWyPga/sh1Js=;
 b=PwFPmmhdaDPmpStmSfDLQoG0iOc2hihIkoMsqdUGoIqnieDtek19ZMu9+tdJtqrKaNfU8DH700s0yJO6V6BQKJhvJT8IX/9wRxJmH6xO9WLOKTk96g2mnpJzKSupDvyIBec/xOTVo6nE8Ea1s7oEDaEWd4ks1KFzkzzmYg4T42rVwU/tmjr3lTEzWECKtq10m5d7+IdC+WR0UlNQjdXErJLLxFKLVvCxbvSiIpG1YEdVgyfjhG9+eHB9OLHQ+tzYzhCSwrO9H/I5f+TzCnx471nop+9krKF/vhdoS2g5n8JKiDfXpX7kSAc4mBkFIwLIMarjAWh6EjGClB+l4RJXBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=726ONQ0tLrhuCsaHakiNV6jaiJz0PhpPWyPga/sh1Js=;
 b=mWasIRiZL+U2A8D4Nw36sJMVUhdr1wPcuoGlHjPS62c1gIj30Z2VxU/c62kQfq2kBQoJmCDt9H1uFFh2nRACOPBa9qi80pEODCDpwCHlkDE2kGUEmgT9xuts6SyA9x8yadP6l/30Zj+Ilf9/h4YYfOgU88IEC4EMuKV1v9V3MOg=
Received: from SJ0PR13CA0104.namprd13.prod.outlook.com (2603:10b6:a03:2c5::19)
 by DM4PR10MB6838.namprd10.prod.outlook.com (2603:10b6:8:106::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.12; Fri, 23 Jan
 2026 14:58:58 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::77) by SJ0PR13CA0104.outlook.office365.com
 (2603:10b6:a03:2c5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via Frontend Transport; Fri,
 23 Jan 2026 14:58:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 14:58:58 +0000
Received: from DLEE204.ent.ti.com (157.170.170.84) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 23 Jan
 2026 08:58:52 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE204.ent.ti.com
 (157.170.170.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 23 Jan
 2026 08:58:52 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 23 Jan 2026 08:58:52 -0600
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60NEwnWP2495400;
	Fri, 23 Jan 2026 08:58:50 -0600
Message-ID: <2b13ec3e-767f-454a-b344-87b7f1bfafb3@ti.com>
Date: Fri, 23 Jan 2026 20:28:48 +0530
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] pwm: tiehrpwm: Enable pwmchip's parent device before
 setting configuration
To: Gokul Praveen <g-praveen@ti.com>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?=
	<ukleinek@kernel.org>
CC: <j-keerthy@ti.com>, <linux-pwm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <n-francis@ti.com>, <u-kumar1@ti.com>
References: <20260121061134.15466-1-g-praveen@ti.com>
 <3ck3abtfdqzmatsvfqcbp7bxu7ydy7u37hfkke4xvpatpcg5uk@wfnya5hxrplo>
 <7081d6d7-d2d9-4364-9df2-48961d465474@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <7081d6d7-d2d9-4364-9df2-48961d465474@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|DM4PR10MB6838:EE_
X-MS-Office365-Filtering-Correlation-Id: 9668d3dc-0be5-40d9-ea04-08de5a8fefcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NVBIclRNMzNKR2QvWWQzMWJEY0p1dnlNTXpMYlltNXJsa0tSVmRWRlZFTGhU?=
 =?utf-8?B?VDJicEU0aCs5QzJlb3RqL0Y0aityQklnWFJUTFQzNUNJY0NtcTNhYmRDTWpo?=
 =?utf-8?B?WVE2TEZKSVNSclZ5RTB0dHdSWFUxNnc4cG1UbDRUZDc3amMxc2N6azE1ZGda?=
 =?utf-8?B?eUU5NHBWQU1taGdlK2hXTG5jWmEzSStqSVRyQ3hXVjZZQVlGb1R1aHhjdjI3?=
 =?utf-8?B?Z0hEbmFJcDZmdlFPMisrWTZNQ0lSR1Y2RU9ZSlJZZHdTWCthaVIrUWRwM0Jo?=
 =?utf-8?B?Mnd5amVLOUJvOUUrQmhUQWVSYUJETm1NR3A4eUVXeXRUUGFQb1JQbnFiYW9G?=
 =?utf-8?B?V3EzdjlncjR2OTVjRnlNRExBSnFZWi9QaXdRTlN5b2dsMHB2dThnYnJDaUNu?=
 =?utf-8?B?ZmQvaUJCVDZ5aTJFNnd6K040SW1TTmpMcDd2WCtEV3dhMEVpYkdDdFB1cU5V?=
 =?utf-8?B?NFN5ZUl0WGxFektIclJQLzUyZDlFekptdHhRVEYzaDNVc3M5THdIcEk3aG9W?=
 =?utf-8?B?SS8wMitLR3ZtaWNaY3ZtaWYxajIrSm1ZYzIzTHJlSnNWM3VKMWhvTndHd055?=
 =?utf-8?B?empGLytSUWpqRlRRcEFGblJ6QWp1VHNBWllyV2E2SEsvNlJxM2U2ems2dHly?=
 =?utf-8?B?SDAzeGZhRjJ1WktEclF3YjJHOE5vZmhWYnhuZVY5Um5WZEZOOE4yUDBrK1Mw?=
 =?utf-8?B?S3RHWG5ZOG0xK0oycWtkaE05VDNZTHVjS0gvSmFsYUdMMkRidTVra04zamlK?=
 =?utf-8?B?QkJwRUtvRWU2QVJLYWFiODZJK3lEOE1ia3I3eEV2aUJpNko3bDVBMUJQbjRW?=
 =?utf-8?B?d1BTOHA2WWV3eEJNakFOejlWM05qZ21BSUsweVZQSzk5S1N4Szd4cVdKL3I5?=
 =?utf-8?B?RjVYdXFLMUNXV0FwYldJWWc4eFRIUSsyM1pndmNZdnVxZTJNK0tzWkVHY3dC?=
 =?utf-8?B?M1puUFcxa0lKYlVDV082Ky9BNUNKMjFHZXFxL1U4QVJtb0pQVm1LdTlWcHpl?=
 =?utf-8?B?aEJiYTBaeUx6OG5hQVE3NSt0dFhGakdnRnVEaTFlS2FVa1VZVUo5eDRSZzJZ?=
 =?utf-8?B?dVJEY3BxbUo4MUVQSUROZWlTMnJOaGVGb0dqUEl4aHFhRWRyVXhuMzRXNXdX?=
 =?utf-8?B?RnVUUTdQS2NqYTNwem1PQlQ3ejJSWVkrTjhEbGZtUFdDRC9xNC9FNXZRclF6?=
 =?utf-8?B?WE1WUlN3Um5DWkkxZEFjZGluQ2lVOGhzWnpoay8wVjR6MGZpa3dlRjdNeHBD?=
 =?utf-8?B?UnM2NUUrTVhmalNmeEl6NTMrZFRuYUd4M0pkNGF5cC81UEpHY0cxeFA5b1pn?=
 =?utf-8?B?TlE4bm84UURZUXlva1JDVVRLVFBBcWVwaXFPdkFGeGg4a3YyYjNpSlZNalZy?=
 =?utf-8?B?OHdYbW11bXVYQ0tOUjJrRXV2Z21kZFpMR1daMzZuZlp5bTJ5eVhQYnp0UXNS?=
 =?utf-8?B?Q2FxaVlST3U4VGMvZ3E1UTBoUmU0M3U4NlZnK08wcGdPcHFGV2tBOUhPMEJU?=
 =?utf-8?B?SnpHKzJ0RVYwV1BpUEc1Zzdualphb0dmLzJ2MjNIaC9aWlFkeWRzYjRLcEZv?=
 =?utf-8?B?V1dLeUJIK0R4bVk1ejhOdVB3cm0wRzh0UGhYTml2ZURvQnpmRGJEMUZLemly?=
 =?utf-8?B?amR2Smd0YVdIOGl5ZDJTS3lLVHc4ME0rT1oyaWs4YkxiL1VpSGJOdDNVd3Z6?=
 =?utf-8?B?WWs2a3BBTjRLUjU3eDAxWHhOTTJ0RWJ3YlVlRzBMUDBRRytKS1cwVi8rVmtk?=
 =?utf-8?B?bDZCQUxTeDJpTlp5clpSd29Hb2lVaTNLV0tZNjhveHBrUmlkdGFTSi9PVjZR?=
 =?utf-8?B?TFIzdzBjSG9BQ0lsK3VkUm9mYTJvRk9udmFWaEdZMGRNSTIvNkVES3RadDZX?=
 =?utf-8?B?dlNqQ0xOamhmdGYzNi9jdXlTdjlyZHJaRzU4TWtJY08vOEp6WUEzbTZQaU81?=
 =?utf-8?B?Wlh4dnVoa21abDR0L240aWo4eVluQUtNVkFsNlRwQmRUaWZEMWJ5U2tkNVlM?=
 =?utf-8?B?bGw1OXFsblplMGhuWEtDRkxYNUxpNGZHZERZTVZVblJRSW5iSzhMWVlDWDNJ?=
 =?utf-8?B?RHpBUnZLVzZiVGcyQ1dLSVFNSlhvc2NTdGtrL2lYdVA3dUZ0OXdsTmNmMnRS?=
 =?utf-8?B?OVNxTVZwdU1DNTk1Rm1zUWwxZm5QcDErOGNFQSt3eEdKelI0YkJGYkZVenBr?=
 =?utf-8?B?aTYrcFBJbGQwYStJQXJpYUUwaGRCc1VuYm5LQnNtLzViNU5nbWNkT2ZTc0JP?=
 =?utf-8?B?dGg5ZXhtQXNQaU9Gc2VRSWZkajF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 14:58:58.2109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9668d3dc-0be5-40d9-ea04-08de5a8fefcf
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6838
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-7998-lists,linux-pwm=lfdr.de];
	DKIM_TRACE(0.00)[ti.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:email,ti.com:dkim,ti.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u-kumar1@ti.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: A83A7776A4
X-Rspamd-Action: no action

Hi Uwe/Gokul,

On 1/21/2026 4:19 PM, Gokul Praveen wrote:
> Hello Uwe,
>
> On 21/01/26 15:48, Uwe Kleine-König wrote:
>> Hello Gokul,
>>
>> On Wed, Jan 21, 2026 at 11:41:34AM +0530, Gokul Praveen wrote:
>>> The period and duty cycle configurations on J7200 and J784S4 SoCs
>>> does not get reflected after setting them using sysfs nodes.
>>> This is because at the end of ehrpwm_pwm_config function,
>>> the put_sync function is called which resets the hardware.
>>>
>>> Hold the PWM controller out of low-power mode during .apply() to
>>> make sure it accepts the writes to its registers.
>>>
>>> This renders the calls to pm_runtime_get_sync() and
>>> pm_runtime_put_sync() in ehrpwm_pwm_config() into no-ops, so
>>> these can be dropped.
>>>
>>> Fixes: 5f027d9b83db("pwm: tiehrpwm: Implement .apply() callback")
>>> Signed-off-by: Gokul Praveen <g-praveen@ti.com>
>>
>> I applied this patch to
>>
>>     https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git 
>> pwm/for-next
>>
>> and will send it during the next merge window. The problem is old
>> (v5.18-rc1~54^2~29 from 2021) and it's late in the development cycle, so
>> I won't bother Linus with it for 6.19.
>>
>
fyi,

We are hitting compilation error with this patch

https://gist.github.com/uditkumarti/d23bc9ee1886bfce70cc76e4b19fbb59


> Thank you for your continued support on this issue as well as for 
> accepting the patch.
>
> Best Regards
> Gokul Praveen
>> Best regards
>> Uwe
>

