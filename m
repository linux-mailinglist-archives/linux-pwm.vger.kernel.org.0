Return-Path: <linux-pwm+bounces-7984-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNThBYGxcGmKZAAAu9opvQ
	(envelope-from <linux-pwm+bounces-7984-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Jan 2026 11:59:13 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B7D559D0
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Jan 2026 11:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 328C588212A
	for <lists+linux-pwm@lfdr.de>; Wed, 21 Jan 2026 10:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E9C3D647D;
	Wed, 21 Jan 2026 10:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="R5yACOFt"
X-Original-To: linux-pwm@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013038.outbound.protection.outlook.com [40.93.196.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871753246EC;
	Wed, 21 Jan 2026 10:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768992554; cv=fail; b=rbzj+E4Jnl/pIUsEIAuFgIMyYW807yNWCeejcaCy3/yaAxruHRIW42RcrRc1R5C458wkjEuxFs0C1F5sGvCJb12g1LgrA/fBPfo/e3QZjkOeeuFg/3fWYcBo6F1SF0XxRYdzh/DqzLgY+JE6aCg8XkqlQkREaMxp01qxE115j2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768992554; c=relaxed/simple;
	bh=haO9f5MhnJd0Lbu7ID2UTtkPWLh/bEGwETpgdcRyu7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HHSwb23mJzb8wfBI3xsp3z01YWxd7aAGji40Okr2Rxx+WIS8k6UXO9XWTFkeZJH4gEh+MYbOTPLayiM0Q8sacyyH4Oij9nBSwMMGYOtuk9jNwkXBoxbbQJBwLoHBA85TRKlMkja3KH+5tDLzqZRovBPZkpj60BfPFfNttN1Qmuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=R5yACOFt; arc=fail smtp.client-ip=40.93.196.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNoG6hRT25ViDgZiECyrmfYTiivm4jFjE3i/MFaK39NUz4vB5M0kIgV8XyDH9vK++TwFiVq1LzbrhhzL4SxoO7TpDzeg7Hsf42xxIQT9FPYu3IuNb4dT1tQaadRGpAwwaPAIBNryYhgaPhLX7mKXggZA8eyNYR4LC/BO54+vUmto0oH1Gx+ppSKFyl8KjhE9VfnosBbIGYoDfMBTXSL9nc7cQ27iyd7VSEcst/MHDll0rIzgi/mZdVYgqWdBzakoLl8NkiFM6ashM9ygPKKc31AVrKVQySCsW4IXuwWXnYmgGkl1ND5u0aDx95/KxIf9DuCSkozvxOBHunWRKmDR7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kf1JLnszaN1GcNhPZ9m/n2fmbeeZ4bWWVzTg9qsxMvQ=;
 b=UwjLqE6BlgO86tPkvZTHbH0o3j4FLKi7GtMLubkAZKOo7wqELdjdj16JMIVuUBVx+r54Wg4VwJ8N8ed1YvRSRALkGamjhpsy78a2KlkaF3Ycuc59pgoA2s5lb/uW03T02+R0oHWgI2aWmZEyIsldXevvf3BVMo3GN9nwDgyjhAD+Kk0SGqqpApdo1nbldYP/R2TqRVkLOLSWLS0BjtQK+ExXg95dGMn7Fdds6zeH9mv1Alxj0542DtguW1SS6uHOnJ6WY7HBUhRJTLD0ZD9KXKwEYAyIZdE9hnagX4k5E0IM7aH/hxoFNTLWSE2h9/udkxDXmEMNIFJLAnx2D2tUww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.195) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kf1JLnszaN1GcNhPZ9m/n2fmbeeZ4bWWVzTg9qsxMvQ=;
 b=R5yACOFtGq9rdx9PQVWdVEZqi5gCL3Dm2mRFXRqNm9tyg1UiVqHcwiMhhUTdi9tr/nOGN+0nElp6ZaO4L16fKD/LsDGsb0qM0s9nQkfm43e6hlxwlhz9XvS4L8Ot9CRoPMF+DD2ck6TbecUslIiI0XZohHz6gFAJKhYz/NTqOsM=
Received: from BL1PR13CA0311.namprd13.prod.outlook.com (2603:10b6:208:2c1::16)
 by PH7PR10MB6132.namprd10.prod.outlook.com (2603:10b6:510:1f4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 10:49:08 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::23) by BL1PR13CA0311.outlook.office365.com
 (2603:10b6:208:2c1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Wed,
 21 Jan 2026 10:49:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.195; helo=lewvzet201.ext.ti.com; pr=C
Received: from lewvzet201.ext.ti.com (198.47.23.195) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 10:49:07 +0000
Received: from DLEE207.ent.ti.com (157.170.170.95) by lewvzet201.ext.ti.com
 (10.4.14.104) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 04:49:07 -0600
Received: from DLEE213.ent.ti.com (157.170.170.116) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 04:49:07 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE213.ent.ti.com
 (157.170.170.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 21 Jan 2026 04:49:07 -0600
Received: from [172.24.233.104] (a0507176-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.233.104])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60LAn4Kk2879529;
	Wed, 21 Jan 2026 04:49:05 -0600
Message-ID: <7081d6d7-d2d9-4364-9df2-48961d465474@ti.com>
Date: Wed, 21 Jan 2026 16:19:03 +0530
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] pwm: tiehrpwm: Enable pwmchip's parent device before
 setting configuration
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
CC: <j-keerthy@ti.com>, <linux-pwm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>, <n-francis@ti.com>, "Gokul
 Praveen" <g-praveen@ti.com>
References: <20260121061134.15466-1-g-praveen@ti.com>
 <3ck3abtfdqzmatsvfqcbp7bxu7ydy7u37hfkke4xvpatpcg5uk@wfnya5hxrplo>
Content-Language: en-US
From: Gokul Praveen <g-praveen@ti.com>
In-Reply-To: <3ck3abtfdqzmatsvfqcbp7bxu7ydy7u37hfkke4xvpatpcg5uk@wfnya5hxrplo>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|PH7PR10MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: acee3ce4-fb4d-4dd3-26bc-08de58dab40e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YU5LZzFnZnZKdnd1Y2k5bWZQU1RiNlF3cGZFTmtVdFZxNGEzVmhqTGlOSUNq?=
 =?utf-8?B?V0RzUmZxdDRjclkwTERmRHBzZUVvVlFoOHZ0SSsxTnNINFJIS3psdSt2WlIy?=
 =?utf-8?B?NDBDcU9nRzFGdW5PZG5nUWI1TXJjR1oveW5XOVZ0SldBQmxZRXdQT3BnaGpG?=
 =?utf-8?B?akJBa2w1TndyS2VwZkdYd1JTTm1aRlh3WHM3Ui92WTRZcjM0T1ZHRTYvZjA4?=
 =?utf-8?B?ZHlrcFQ0RlhVVUNlOG5ET3pPd3FPNlZ0UDY4eEQvemRMVTVoSHFEcFV2Nkg5?=
 =?utf-8?B?OWRXOG9nMFJZUnczRVJ1cmZNQmRvU1I2T3Q0VER2L3NPdFo3eVJWVnhqTDla?=
 =?utf-8?B?aTdnMGdQQnJzUTFBZWtVRW5ZT2dPTnZDTFJzcDVmQzc5eWhEaDBpNk1HaWQx?=
 =?utf-8?B?d3hlUFZ0OHlNZ3hmQXR6Ynplc29mUEZRU1dQcGVkTm53QkU5Q25OV2EvTFJ5?=
 =?utf-8?B?aGt2a2pUcmI1Q3NxRjRIMkYyUVFnQXI0UkU5aWpTLzVVMDViVjd3SmlERWcv?=
 =?utf-8?B?R1VoTmZ5SUNKTmU3bkdqTTd3aElRQXlNb3hHUEl4RVBqQStiQnlra1pvUFox?=
 =?utf-8?B?UTMyMUg3ektJc1NxRVBQaG9HU2dnWk5WOXNrTzI0Wnl0KzQ5NDhISTFONWJa?=
 =?utf-8?B?UFhXdzNxeEx1TnRSelliNnVZNmlVbnQxUlUvRXcwc24ybndNS1MvV292MU1a?=
 =?utf-8?B?NmVFQm5vbW5WRk5JTENxOHdCcHpHa3Yza0E4QWJWcXhlNzdKUnVkREFxbnJw?=
 =?utf-8?B?VWZHZ0lnTHBTWTIwUnhGbUZPR0xHZDdNS3VnQ3V0TVpWenhKZE0ycG51a1dJ?=
 =?utf-8?B?NlhDaURSVGZZSlQ4aklLbGRqWG9jVVJ3ZkRCYUVTMDliOUlqbEg3ek0ya3Vu?=
 =?utf-8?B?WFhZT0RBajBhM2lYemI1NC9xUW9lSm1iQW45RzB5N2tBQk1tazd5Q2hSUTdK?=
 =?utf-8?B?ZVdGS1p4Q3NTS0E2bnROcjJSQ0c2N2VnUWNwcXk0cnVkazJGclc0dU5LWjI3?=
 =?utf-8?B?VGU0Zk9GeHRpR1g3dCtRaHBCbXZlVU5iRW83eVI1aTNMU3paWVNqaStWTWtQ?=
 =?utf-8?B?NUFpSDl0YmdWNGNsVGloa0U1bjJLcXp5QnBMOWJjNkRUNU4vVVoxa2FWemtT?=
 =?utf-8?B?VDBIZnRBdkppaUR4cHZZSW9iL25ndDRXcUplL0dlMlFIa3JhQ3o4cGhKdERp?=
 =?utf-8?B?UmdPeU9Ib01QVTFxMDRNTVgrb0Q1bVVyZGJRK1J0U1hmWlRIeHhMTlcwTlJ6?=
 =?utf-8?B?UjVjdnZudkl3akd4MzFUa2lWR0pUT0ovaXVVRHRJQlZDbzloRUJHVVVzYnI5?=
 =?utf-8?B?dUR6N25CTG0xcm9jeUlZTExieVgwSHExRVZTTkF5UzdrMEh4ZXA4NDdQV0sr?=
 =?utf-8?B?WWtvL05qdjUzTEVBTzY2NERBQzRhOGY2OHdSL1ZyMlljNEh2WFdTNnhaWGl5?=
 =?utf-8?B?a2NoWlBWdlM0UTdXR0lQNk9XTzlFdFBUb2sxVWhXalAvdVpLeTdxa05hTHBJ?=
 =?utf-8?B?U3dqamVkMXFxNTEwbG5LNjY5NnJaN3N6VGZEK1lpNDZHZmQwZUtDQ3N0N0dK?=
 =?utf-8?B?NzViRWtTMjlrQ3l3cXhHRVpjaDBlLzVLMnJKT3VKK3Z3VTEwNXJRbXhieS91?=
 =?utf-8?B?VHJaamxNNUxaOGZ4QXpsRWZmK0NpSkRYL2Z4WGJucjQ1Q2NRZCswQXk0OWVM?=
 =?utf-8?B?TTQxWEZoaFlZK0tkR3RJeXdhN3ZiN3JHSTFHbzhGWXM3elljRytmdnpDZW9C?=
 =?utf-8?B?ZEg5cktNQTMwY2ZrNjFFNkg4djU2LzVMU3kzakNOalZGMGV4aVMveHoxdm9h?=
 =?utf-8?B?czkvU2JLT3AvVHpwdTliSGdHY2tUNWhJUEc1Q1JxWElKNUgyUFYva1JMS3ZQ?=
 =?utf-8?B?OVZweG1RZkJibk1MZG5qemVESHl2OXBqZ0g3NnRLK0E0V01JZFU1OGtteXpj?=
 =?utf-8?B?R3ZQLzdOa2thMTBPVEFicEdyUUtLZmgyNFJTL1YrLzdEMC8vV2JwYXlWLy9t?=
 =?utf-8?B?U2FndVc4bnYvRHo5QzVtOUI1aEtaQzQ2RXlRc1QyWVlrYjk5bEY5aXhrYlJz?=
 =?utf-8?B?S3h0ekIzN1h4MjZQdE1VRGU4bTl2aTNCLzFXaEJqUUY5YUFjOW5TY3VEc21n?=
 =?utf-8?B?SW84ZHpnb0kwVkR3NWREYkNpalZoV3RySExyckg4TzMvWWx1UG1CbVBEdTZU?=
 =?utf-8?B?bUl3dDk2ZGNFQ1dGeC8reHN6K3pJNGFqR2NzVDFmOXcwdDBYQVQyVmVhWWp6?=
 =?utf-8?B?VVNGZFlIcSsvUWZjT1dPSCtmYWhnPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.23.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:lewvzet201.ext.ti.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 10:49:07.8976
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acee3ce4-fb4d-4dd3-26bc-08de58dab40e
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.23.195];Helo=[lewvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6132
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[ti.com,quarantine];
	DKIM_TRACE(0.00)[ti.com:+];
	TAGGED_FROM(0.00)[bounces-7984-lists,linux-pwm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,ti.com:email,ti.com:dkim,ti.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-pwm];
	FROM_NEQ_ENVFROM(0.00)[g-praveen@ti.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 93B7D559D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Uwe,

On 21/01/26 15:48, Uwe Kleine-König wrote:
> Hello Gokul,
> 
> On Wed, Jan 21, 2026 at 11:41:34AM +0530, Gokul Praveen wrote:
>> The period and duty cycle configurations on J7200 and J784S4 SoCs
>> does not get reflected after setting them using sysfs nodes.
>> This is because at the end of ehrpwm_pwm_config function,
>> the put_sync function is called which resets the hardware.
>>
>> Hold the PWM controller out of low-power mode during .apply() to
>> make sure it accepts the writes to its registers.
>>
>> This renders the calls to pm_runtime_get_sync() and
>> pm_runtime_put_sync() in ehrpwm_pwm_config() into no-ops, so
>> these can be dropped.
>>
>> Fixes: 5f027d9b83db("pwm: tiehrpwm: Implement .apply() callback")
>> Signed-off-by: Gokul Praveen <g-praveen@ti.com>
> 
> I applied this patch to
> 
> 	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git pwm/for-next
> 
> and will send it during the next merge window. The problem is old
> (v5.18-rc1~54^2~29 from 2021) and it's late in the development cycle, so
> I won't bother Linus with it for 6.19.
> 

Thank you for your continued support on this issue as well as for 
accepting the patch.

Best Regards
Gokul Praveen
> Best regards
> Uwe


