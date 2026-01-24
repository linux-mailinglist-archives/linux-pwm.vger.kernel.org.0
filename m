Return-Path: <linux-pwm+bounces-8002-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCjDCjBRdGk94gAAu9opvQ
	(envelope-from <linux-pwm+bounces-8002-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Jan 2026 05:57:20 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF8D7C854
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Jan 2026 05:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4239300DE2F
	for <lists+linux-pwm@lfdr.de>; Sat, 24 Jan 2026 04:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FC5314B97;
	Sat, 24 Jan 2026 04:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wM4E3CTM"
X-Original-To: linux-pwm@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012061.outbound.protection.outlook.com [40.107.209.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB72145355;
	Sat, 24 Jan 2026 04:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769230637; cv=fail; b=SadplS0xLl3B7oUXfFSvyXTux/V3Vk+dMqLHnHWBw9+HXlWnGN/Kdn/UJd43HUb+5sWJNf0htXKqeLNZqi7Oo47wWd3JohHPSiIqkl370fNC0GC/jZOeIfXuLkAz3Ah/b8SPhMVof7OzmWq5nIb9mdNzFSvi/gc31cb80kA3uBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769230637; c=relaxed/simple;
	bh=/0PDY394BRl//31xgwAnqLzNC1CLy4LkxBAt2CQxp4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=d4DNTMzniyqcHlXyPuipKsM1RO4cIlZAOWVzRBubBc6ce6uDWSTSjuS6nqnoGVME9wKq2vfv5RfKLln8oYv6PP5e5/TCPfrMWTAC4EgmBYKlLMmy7ASgZg+0bnV9d7d7XwDqzVBU2vJKBUG7QN4qfXZwqJV6GisBByP1akQwcpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wM4E3CTM; arc=fail smtp.client-ip=40.107.209.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBsffemaI8vvadKH7bYXF4VlwThcVwYFCqZqD2/4fstXYwHI8PQNvRWOsSpAVqr7NUSOOhI+FHbruRIS8hpY6oDIGrhNQNhzUKYmg+Njfe545i6XDpD/4lGDesk20EifOIeSNrjrGPOTAypzzKpSITj6aBB1otTDaQFC3+bPPnEu4PXQ5ZILXr7SiDPh4NfsTjYm3Ezo2DkeBTWQMnJqe82BN38mvi9FlkufDMBCY8BF9XYL+WM+VFgYxE+5uLiWFHtCwfrUVNORzXT7FxONG8F2MgasPLJKKPIS2tYtshjOQXKwCnh+TsZn5dBjhZlx4ytBmflmbn4nAO6LbB/SQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pqrlgFEr5GoA16bv0aacWixQxKvmImV05fF8wc6L9pU=;
 b=y7nmWLtpVwrM86w2b94bYojyolOCAMve893qfYkseBvZXLpkQNwVpNMjO43mjMw7HTyGLv9dBjkITZQ8kabwi7IpM0Tm0PjjbI29vwd8rJeIMPnfFZgnOmNNJmk71prrBAwQ3Bf6vBPPlKgxnqLSgBS000iV5FU+DWSMVOcgSf5kVJUS3zcXYVKNR92nAh8yBihRc3oLrxRpx8YHiEWy7WVqgfk3pNblVb3n+yxSz5hT0uJdSHgZOcugZJATvv9gsQ7tPiKwVEPmwRS9tsfZSdZIAbgp7IME/nKhDFrBKopt7y8l8N78qtFoRcxn127Ea+bTDLRGmzNvhrjblLGFLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pqrlgFEr5GoA16bv0aacWixQxKvmImV05fF8wc6L9pU=;
 b=wM4E3CTMTfmkGX0lvN1eVyvWSN86Gn12iI+fdDRbnvxFBXVZ5ED7Pnr4JUoP2QdZKfUbaumeS9pOAVYO6IYHG8ppbhSsse8Hv/So9GwFccO6Y6Hue6M6XrPxjDvgi6BNhNTsbTWBKPdh4ZlSZL4+rsi/QNivAOKZnDtdcBV+idA=
Received: from SA0PR11CA0045.namprd11.prod.outlook.com (2603:10b6:806:d0::20)
 by SA1PR10MB6342.namprd10.prod.outlook.com (2603:10b6:806:255::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Sat, 24 Jan
 2026 04:57:12 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:d0:cafe::bc) by SA0PR11CA0045.outlook.office365.com
 (2603:10b6:806:d0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Sat,
 24 Jan 2026 04:56:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Sat, 24 Jan 2026 04:57:11 +0000
Received: from DFLE200.ent.ti.com (10.64.6.58) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 23 Jan
 2026 22:57:11 -0600
Received: from DFLE203.ent.ti.com (10.64.6.61) by DFLE200.ent.ti.com
 (10.64.6.58) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 23 Jan
 2026 22:57:11 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE203.ent.ti.com
 (10.64.6.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 23 Jan 2026 22:57:11 -0600
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60O4v7L83439064;
	Fri, 23 Jan 2026 22:57:08 -0600
Message-ID: <11f86b32-8bdb-4abe-8acc-30938b405275@ti.com>
Date: Sat, 24 Jan 2026 10:27:05 +0530
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
CC: Gokul Praveen <g-praveen@ti.com>, <j-keerthy@ti.com>,
	<linux-pwm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<n-francis@ti.com>, <u-kumar1@ti.com>
References: <20260121061134.15466-1-g-praveen@ti.com>
 <3ck3abtfdqzmatsvfqcbp7bxu7ydy7u37hfkke4xvpatpcg5uk@wfnya5hxrplo>
 <7081d6d7-d2d9-4364-9df2-48961d465474@ti.com>
 <2b13ec3e-767f-454a-b344-87b7f1bfafb3@ti.com>
 <d773qlfhifbtn6xtkuowdu3l3h6em7hrk2etsg3n5umuiuhfu7@yuetzfci7pni>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <d773qlfhifbtn6xtkuowdu3l3h6em7hrk2etsg3n5umuiuhfu7@yuetzfci7pni>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|SA1PR10MB6342:EE_
X-MS-Office365-Filtering-Correlation-Id: c922e4b7-573c-4ca7-e2ea-08de5b05090b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VkVGZkpIT2N5WUJyUCtlckVQK21ZUVBMT2dXVWs2NlNISCtpZlRycUN1dXlS?=
 =?utf-8?B?d2N3L2lOMElOUHYxL3dwUDV1VGc2b0d4K3dFdFRsRTg5aGRZNHllWGNEcXRo?=
 =?utf-8?B?ZmdWYiswQmtMd2hzL1hKMnRpRmw4ZW1mU1VEVGNEdzBoNHVES092ZFBZNU9i?=
 =?utf-8?B?UXdQVkhWZ0oyb2xWV1JkY1AzS3U2RThxQWZjV2drc0EzaWZENGJpOEk4ZHdZ?=
 =?utf-8?B?Zkc1YWRCbVpxOE9uNittTHQxK1R4aU8vbGFNdkVIekNndVE1d3E1OHpHakZa?=
 =?utf-8?B?a2JzU0RHZStIb0pOOVdjYVE5SjZLRWoxZXRkbE5tWDZQZkFGbUZESUFNM1dm?=
 =?utf-8?B?K0xzU3ROdEt6bHFVRUtoSHVWREcxYlBMbkFKTXp0S0lHeDlPWmhGZG5OVEEr?=
 =?utf-8?B?YTFPeTU0bG5wM2pCeDFnSDZhUHNvdjdDbE5wMzRjdTcyamhLMVlHZE1XMlpF?=
 =?utf-8?B?azJWOXhLcjV2eGZBV0hRV2ljWVowQmJ3Mm9TMG1QNW00SW9lUisxRWxJTVY0?=
 =?utf-8?B?U3RyVm9vNXhJL1VCcTRWSml0d01xb1BlbUowdXRxUE9FazFBZm82MVRDZmpl?=
 =?utf-8?B?Q25LZm5yUURwYW9jdnBOYW1LcG9hWDY1blBadDdpQUwyanNuTVNzaXZkWHZ0?=
 =?utf-8?B?Ty92UGJ4M3VwSDVmM1pNWEJoc3Y3QVFqTyt3MW1PSkVhSEQvZ2VURDJ0ZFZJ?=
 =?utf-8?B?ZTAxbk1IWm10Z1M2dSs5dmJYaGl5dFNrSDhlei9uRElwM2JHVkxMZllYbUhs?=
 =?utf-8?B?WlcxUVppRlJ2aGVPT1hPNnRPR1M1MmdMaW9CM2tTQ2g1eGV3czlBUEI2bWg3?=
 =?utf-8?B?N1NyN0hMZHhlbEdiWXdndmZJTkRoUHlYUGh4dU5jYWx6d3ltYXdDZnNKS093?=
 =?utf-8?B?aDBBc3BjVFdNQk1MUk9wSmlHazhBTEJkVm10MStjcUR4Sy9Yc0FZQU9rbDFQ?=
 =?utf-8?B?TU1uM21KTHY3MlZobk1kdzhWY0d5OW9uUXFWajhpZ3RFemExVGFvcHdTTG81?=
 =?utf-8?B?ZlVSVnZYTXk4QnNtNlM1S0poTkZ2eEluS1JuK2hmVWFRYWVkRlZmSzNIWmpD?=
 =?utf-8?B?eXBmaXVZWDQ1ZnByNEhRaVZ1bWovbExrT3FjeG56Vm5COUQvNWNRVExjTDVh?=
 =?utf-8?B?b2ZnL0M2YlFjRWdYT0F5QzdmVXM3N1BNaVFyWjAxR0p3N0J6Q0hrcTJpbm0x?=
 =?utf-8?B?b3ZhM1kwbEJFUEtteDBsWUcrZXd2R3RoVi9SNWRQa3pDWHpyM0U0M2FUVW9C?=
 =?utf-8?B?WDk0TzgvdVc3ZUlPK0VDMVJFd0V1RzRhWi92emRUeEpycVNpS29XS1hKb1lP?=
 =?utf-8?B?Sk1sVVc3SzdVTGxjRDhsUTZGYXFJUXUzTnljQ0x5L2dtLzJ4ZVhsQ0xnQkxF?=
 =?utf-8?B?cnZvVEFaY1ZnZjU4WnVia3dsYjdkZEVDNlV5Vkp4d3VMT2F3U3RsVFdGUjRX?=
 =?utf-8?B?NFdLVkI4VFp1Y3c3UGVqK2xuU0drUnJhOGNpalI0MU00ckFSZXRXRHZ1UTdk?=
 =?utf-8?B?Q0doQ256TXpVT0JQZ1N6VTl0bUlRRnZFL3RTQmIyYUIzbGVuTW5nY1RIWUlD?=
 =?utf-8?B?SnBxUHQ4UUgzOWE0Ny9EL0JESlpMdmtxUjdOelp6S2ZyZFgzcTdRSm9hYmhi?=
 =?utf-8?B?eWIycENYbXdlMHpKNjRSZDVWQzR3RnltbFlLN3B6SGowd1lHVFZEa1B6RWFv?=
 =?utf-8?B?SjdhUHE0U1hwazM4NjNUU2RzTjZKYy9adm0vZlVBSFhZTFU4TkFpeEltWEhr?=
 =?utf-8?B?cERPVE95UWQ1bmJkSWovYW0vNzhic0d1WTVrODllNlkrTUNUWWJGTVZyVURk?=
 =?utf-8?B?eEpWUUg0OEIxN3dGVTRxZmZ5M3ZWNDJleHg1TUFnaHNBOTBXTXFzdlYwVzlD?=
 =?utf-8?B?elZUcnJjM3JCa3BncEozV25ISmJUSG02cEEyc3hURVAvVHRZWUlUdk0xbUZ0?=
 =?utf-8?B?WGlham9tRmpuMHN5TTd4VkVMVG5ESTY3dWQ0RWlBc0NqMzJmdmQvcmxVeG8w?=
 =?utf-8?B?NjQ3ME9VNXdDSE04b29iZkdrSVVVbUp4STBLWWhQa3JUK1lQRERDY0VyVUYw?=
 =?utf-8?B?a1RqMVpDbmNlaXJpTWVjRE5NOXhhMTBwSHFzVnQzNm4wNFE4Nlg0VG54MURK?=
 =?utf-8?B?R1BlWUNJVzJzREJVdXRWTVduM0k2UC9uNGRrazgwczBCWjN1eW1YVjBHR2ln?=
 =?utf-8?B?ZmFyS3NBUDduOHRMQ3lXU3pQNmpLbmxVZWY1TnZSZzErdFh1OGZHVDEvY1dw?=
 =?utf-8?B?N3RZeXBWbjZYMEFBKzFmNm9RamVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2026 04:57:11.7247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c922e4b7-573c-4ca7-e2ea-08de5b05090b
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6342
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
	TAGGED_FROM(0.00)[bounces-8002-lists,linux-pwm=lfdr.de];
	DKIM_TRACE(0.00)[ti.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u-kumar1@ti.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 3FF8D7C854
X-Rspamd-Action: no action


On 1/23/2026 11:31 PM, Uwe Kleine-König wrote:
> Hello,
>
> On Fri, Jan 23, 2026 at 08:28:48PM +0530, Kumar, Udit wrote:
>> On 1/21/2026 4:19 PM, Gokul Praveen wrote:
>>> Hello Uwe,
>>>
>>> On 21/01/26 15:48, Uwe Kleine-König wrote:
>>>> Hello Gokul,
>>>>
>>>> On Wed, Jan 21, 2026 at 11:41:34AM +0530, Gokul Praveen wrote:
>>>>> The period and duty cycle configurations on J7200 and J784S4 SoCs
>>>>> does not get reflected after setting them using sysfs nodes.
>>>>> This is because at the end of ehrpwm_pwm_config function,
>>>>> the put_sync function is called which resets the hardware.
>>>>>
>>>>> Hold the PWM controller out of low-power mode during .apply() to
>>>>> make sure it accepts the writes to its registers.
>>>>>
>>>>> This renders the calls to pm_runtime_get_sync() and
>>>>> pm_runtime_put_sync() in ehrpwm_pwm_config() into no-ops, so
>>>>> these can be dropped.
>>>>>
>>>>> Fixes: 5f027d9b83db("pwm: tiehrpwm: Implement .apply() callback")
>>>>> Signed-off-by: Gokul Praveen <g-praveen@ti.com>
>>>> I applied this patch to
>>>>
>>>>      https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git
>>>> pwm/for-next
>>>>
>>>> and will send it during the next merge window. The problem is old
>>>> (v5.18-rc1~54^2~29 from 2021) and it's late in the development cycle, so
>>>> I won't bother Linus with it for 6.19.
>>>>
>> fyi,
>>
>> We are hitting compilation error with this patch
>>
>> https://gist.github.com/uditkumarti/d23bc9ee1886bfce70cc76e4b19fbb59
> I assume you tried to compile this patch on top of a tree that doesn't
> also has commit 9a0abc39450a3123fd52533a662fbd37e0d1508c?


Thanks for pointing to this , I just cherry-pick only patch of Gokul,

after picking 9a0abc39450a3123fd52533a662fbd37e0d1508c, compile is ok 
for me .


>
> Best regards
> Uwe

