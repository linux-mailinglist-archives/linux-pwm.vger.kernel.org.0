Return-Path: <linux-pwm+bounces-9514-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bGCaE0hER2orVAAAu9opvQ
	(envelope-from <linux-pwm+bounces-9514-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 07:10:32 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F13486FE989
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 07:10:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=IeKTJOju;
	dmarc=pass (policy=reject) header.from=nvidia.com;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9514-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9514-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C39F3044596
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2026 05:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 664E738837F;
	Fri,  3 Jul 2026 05:04:45 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010028.outbound.protection.outlook.com [40.93.198.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1A0381AE2;
	Fri,  3 Jul 2026 05:04:30 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783055083; cv=fail; b=Z0QWV8c+UcywZxTCAblz7JgIcMmiKBufy0sEKd5CXfjgbFncqpGdEzwkW4wH8ZnEV4CXI9Vu+6Neo3UF44V5UznFPmWbSMM6HqcPsZocLKdVF0Db2gAvO9HTVu1IQDlIfkjjqZwf07L+Lm8Usi6M2HpNrItlkUmacgicF7//jsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783055083; c=relaxed/simple;
	bh=87R3p3MX4yc3S+2++HjZm4kuBWHoTG3RSttHjnYSb+s=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=MHLV+I7Dw96hOF1iFX4oHN/8uWxH4O53fjZxHjqROY9KBZui3l+dIYp+T/krQYrQ8q9wS9s3P/5kFpLGR132CtbCQQPAc1kt9N1MIVHTO1yz/INUG+h8ufofFAvb8HvmqA7gfniDo9TmtM8lp4AdicSxePFCxzfFA6qM8Lhm9os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IeKTJOju; arc=fail smtp.client-ip=40.93.198.28
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dn67GHfVV65j+XDwyNAQq0MRnej8RAzEBj3+XpRKYJwQSjAafXHq204A34IBObpNkctn65GT1EEqCU0O2MBgC0rcCFtIZEOxOSb/I7JSFFu8bIQAAmATJouRM+d4CZ/HDdZiZlPMQMRxsWGV1QAyjs7l6i1voI3mQIPfjblwGZoZQYbpq//oQj6xA4urkLGMs8jVNCpB5ZAb7lZwemYTX6ATuvX6msxlso+tVmBhpjvwcjLKaPU4X4SqElY3J1BaUs992NkV0iU9I4oBsytswG5tLrTWMbO7p+qqqIfnYjn0MPBATRU4cVZHLKbGFt3iuFXLeWM5g5+4kA98KOB30g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87R3p3MX4yc3S+2++HjZm4kuBWHoTG3RSttHjnYSb+s=;
 b=Og5yshNhSlZywqxVkpCv3mQRlDZ5piTQleuZPpdFC5PEBKiyWHfvjLxct4gEA01t0Ld8UkHp8fvTs7LfEsyRXdfikCE29aQiWDsHwjEGS0SWfGRoaZoVDOZZFgbvkPbEWryeEyjg/XxYjtcSaa61+CDeB1CCbTUSSM6uC4DQ/Ui+WfK9TpRD2xwj00pRxU01rum9aZajyfAwqLJE6e8YoeWmSU/x4uL9O3VBGtpXOF4614qUPyqw9eTOpEQNi/JHjKgMxSGEULxEwNJH0/Eh9isiTNvRNofAVXc5GOrZkG7zsJIfRdSG3MH2//UX4NlJaqno3mhq44X+zvbD2OT7Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87R3p3MX4yc3S+2++HjZm4kuBWHoTG3RSttHjnYSb+s=;
 b=IeKTJOjueUo8DZXxJxFDun2DOYIHpoBZ5/CZvHyctgKbqBIhmbAgkdupZfgOc1U47WW2wZfGdoHy/FDK56eoP84nF+yR04VaMhM6zuxClEPIiD2SVG41TzT39n3gK7fxx2d8ajr38bzlBplhxIUUaVh67d1B4jy581KJKjazvmNougEvTtBX0OjFDt2VqK6jbaHhSRArv/TtyFgX159NbSCNZoMMIpDlxc4lA0DddZMR0sRiWqGIEehUNPVGF0Yp1z9JKGUTLWfibIJYCe6/F300S5hsWL9p0f4MxhjgnWb4j0OulISi9d2MgLvYPnu/RoWpoXQlG2dCPMHgXA8HCw==
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by BY5PR12MB4051.namprd12.prod.outlook.com (2603:10b6:a03:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 05:04:26 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 05:04:26 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 14:04:22 +0900
Message-Id: <DJOO9NLV95JX.FXTHIIDJZT4Q@nvidia.com>
Subject: Re: [PATCH v5 10/20] pwm: th1520: remove unnecessary `deref`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Abdiel Janulgue" <abdiel.janulgue@gmail.com>,
 "Robin Murphy" <robin.murphy@arm.com>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Michal Wilczynski"
 <m.wilczynski@samsung.com>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <ukleinek@kernel.org>, "Danilo Krummrich" <dakr@kernel.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pwm@vger.kernel.org>
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-10-d0961471ae50@garyguo.net>
In-Reply-To: <20260626-io_projection-v5-10-d0961471ae50@garyguo.net>
X-ClientProxiedBy: TYCP286CA0022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::8) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|BY5PR12MB4051:EE_
X-MS-Office365-Filtering-Correlation-Id: ac972695-39b8-4464-a3d3-08ded8c08dd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|23010399003|7416014|376014|1800799024|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	93ClLGXWZk/tGDW2G3zhS9Tx8aws3/OgBaPsl4d8lophha/NC+mYowZ7TBZNqxoNn4WmR7Dlk8o2rpPM61ZastBchnKftOehLBGfeYCbsX5JF0sV1fq3tL9PBqR/LZZ1u6DSmw93KdGZVBef3nTadpXONabxFopFo+8E5x2Bt8fiQJsmSOZ6E5zg6sXm3z9mcP1RJVe4Bs6V+XLO2JaLInlPt2qzXWPnrTPM94OIO53J7S3ZesDzf8xuEGOdz+VsN7L5VIH9jAyw+qbyCOwY/TOGQh46y2rfuyxdAi+eLc4aF+ll4lGoDPVSBDfa6thDKMKavHkogdpd2BbDTLguou06dSHtck2Mh9Y0BFvAVYtDAEJsiQiXnTw0w9NgJG2g2i342p9RuQ4z232+u2vxEBi/djIauH36BCn0A8LdVJNdoGp8uHXYlNkjuWIRZ2vtJ8lZy/omaXv1q46EXT+BSAahLh+n6kXcTMw+2GWNMJR6kxBZNpaUJTSkMKZZ35pKqqjxmEnnndqHN2y4RWe/DesbNTrQgvOLpbS+k/7C9YNCfQi1T0dEI51XXs+EXZ1i/Y6gTT1KjWE8mmPOO+IgUUUXlDJcAxofP4JgiEKNHMnPeaHR/sNmnryc3LH8E+Ejn0v3BTdOKqy5CFPSN8+c4l7YMR9QSFcLplK2vJEUxPI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(23010399003)(7416014)(376014)(1800799024)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0UwQ2E1d0J3SVorUEZQRnBXOSs3QWVQdUpNVGVFM3VqelFCZXR1RlFYd0Ni?=
 =?utf-8?B?alIzR3Z0bVdSakltd3M4NEhlMEZlRm0zdmM3RVBMWkhad09WMWUwNmxkZEdB?=
 =?utf-8?B?a1gzeFMvZ1lNN2FFRmZpZFBweEJISWNQS1ErUTFieFpncElGWS8zaFJjUDdz?=
 =?utf-8?B?U1FrMWdLM2h4WWlLV3pNb0Y2eE1xTVc1ZWtBN3Zoek52VTZicHdSNnA5emhK?=
 =?utf-8?B?WHVkQzgvMUxuUnhaS3dwQ3JOTy9zOFc1REtIQlh6UGgxaW9IWVk5cWhyVXVs?=
 =?utf-8?B?K1FybGFZekZSQTdEZzh6OHVzWk82aVNkNlZuKzNHTDJuanNuSHdmcmYxdmtx?=
 =?utf-8?B?WVdTT3FDR0UyMDhsUWttOW5uTDVhZE1ka3BXaEZIa2JiNkp5OFlUdVhtckdi?=
 =?utf-8?B?RDZ5ckxndk40bnlrTDBnQ1d0K1BWWThKZnpBYlFKZkY5UWEzZ3NlUkNseXE2?=
 =?utf-8?B?WnhNMTgvTlNiRU9Td1N4YzZ4Y2oyWjZkYnVSVHRwd1VoYTd2cEFJbjJCWDV3?=
 =?utf-8?B?MzM3Mk1iNExyUUI0bmF4dmhvWktwMUgzYXFzWDJ1cm14NEI4dnYyRHhYYk9V?=
 =?utf-8?B?VjRjaVppaEpyUTh5Q3liRDlLQTZYY09PUE05YkJmSE9lNDJ6aDl5L1d1YkUx?=
 =?utf-8?B?UDY0NUQ4NGJmUjhvVHMvSXFpSndmWTdBYUUyZG5mTjd1ZnZtUkFidkdlTC80?=
 =?utf-8?B?M3lnWmlYSUVneGZuWVk2NEFpTlhhcWZmVUZ4MGJKVnZQcGtiemRZRW9rYllj?=
 =?utf-8?B?VHRHTzVMVGV6aFZnTGM4MGxyV09DblRYdFBacDhpR1pPUmk5WStHWGc5Vk1B?=
 =?utf-8?B?NEdtK2c3dU4wazA4S3NOS2pPdDV1ZENmRFRtRnJCbHhUdHpsT3V6VEtCSE41?=
 =?utf-8?B?M0Z1enNBRVJJR2N6L1NPd3JqaFlXOWRoaXNKcGxPaDdYaXhVT0YvZGNtOGNh?=
 =?utf-8?B?QUNodUNKOTRzWDBwbFBBWkVnY0pEUGg0bml1SVRvdFBubTVYY0FzL0JyOTJz?=
 =?utf-8?B?REYzRGpuTXBnTk1OMkhBM3hmaFArREw2TkNEUzk1SzduU3pma0EzK0hESitW?=
 =?utf-8?B?Q1ZKZk9nbysyUERBaGZ6QVhnWDcySTN0UDZVMTdVS2tQZEt4Qm9yMlIxZzlO?=
 =?utf-8?B?M0xJb2lSR2kvYlF5OG9NZjFFVzdMbitIdVFlY3RrYlRuNHdiTDkzT1pWSEZK?=
 =?utf-8?B?YW9tbVdFaTZWaElZd3UrYXZMMS9MMEwrQ1JMaU5Sc25wUURaVmZHTTVkT084?=
 =?utf-8?B?MkdFK0tFVVdTdFpKTFlSa3ZNMnhBamt2aHhyUjk1eklPSlRobDBPc1B2c1Js?=
 =?utf-8?B?RkdFRnVRTXViR0RsYUJGNlVwUE9BMCtSZFJOWGRVL3pzTDZhYkxuSFZHMG8y?=
 =?utf-8?B?OCtKSmQwQkRoSzh5dTMwbmRXdXE5b0RVY0RqN2dJSi91Vkx3Q1VyeURUUHZq?=
 =?utf-8?B?RkxiM3RtbUU0enR1c1lOMVhodVQzWHE2cWl4L285RVJITzhNMzV1NmJCNmZM?=
 =?utf-8?B?TzdnUDlvV1FrMEFhNVdlaWExaXprb0p4N0pKcVQwU1R0S1FzOFZyYUpZUWwr?=
 =?utf-8?B?eHhpUkhlOVkxUDBuQVc0V1dYQmwvNjVKYzIrQy90elVwekJYT043d20yU3Jm?=
 =?utf-8?B?WXp2dHBOaTdpMmRnbUN1cDRPZTU4WUh2NXgrMzN4YXJIeVBLUkRYUStrN3h5?=
 =?utf-8?B?MHJsSTMzYzZIVzllSHlEakNkekwrdjZLTlViZEh2Mm94NjJBd0FBNzRlVGJM?=
 =?utf-8?B?c2VBTTNxdXY3Qm5OS0JHUkxRU3pjQ0kxaCtqUmI0WElnYmkzV0RHclF4bVRp?=
 =?utf-8?B?bVpPdlBjamRVZ0VzY2g3RDhLMi83UWIwT01WYXNSNk81amw4SGNQZm1pUzFC?=
 =?utf-8?B?K0VZdFh4SFpDNldLSUl3MFFyRFJmdWV2Z1JkcFNraGZmNDI0MzdjckhYTytl?=
 =?utf-8?B?elRyL3lSZVZZUjdlc2Ira0JNVjhkRXBucUNzTHFPeEFFWlkyRTdtZVk5eURZ?=
 =?utf-8?B?dDR3bUFFWjZtQVNoUEFJdXRlSndPSXpML1NGVXpyd3kzcHk0ekUvVStldGhW?=
 =?utf-8?B?RlpnU1RwMUtXb2YrbkFnRG9SUUJuNEdnaEw2SFhlRlgwSFdYSUxzOHFLSDhE?=
 =?utf-8?B?MDA2SjZ6M0JvV1hmWU9UdzhMN1FsTmtrbmRjWXduMkhhcVVoUGQwR0xuaHpz?=
 =?utf-8?B?Ujl2cVNyWXNNdGFKdXhZT294czZGMDZxemROM1RaRlpDM0lQUFdpa2VzRGNt?=
 =?utf-8?B?ODZwa0NUVDVLVFpWdUZyaFAxSEtBbC9aelgxY0lURitFTExTQXR0OUdKaVRQ?=
 =?utf-8?B?UXFpZjBLZi8xMk01di9FWVFibzlsSmszaGpxRjBvaWNrTUtqN21JU2pJZUhY?=
 =?utf-8?Q?DCrPooaryN/HrlNI0IWUH6EJVRzrC6ck4X70XXjb6hcXq?=
X-MS-Exchange-AntiSpam-MessageData-1: 7ImF6iNC12aXDQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac972695-39b8-4464-a3d3-08ded8c08dd8
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 05:04:25.9773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6lBT3m2tjUNIZyDx5w1EYNWxkZegqZHN2qjJ/JF6V2rlu39RbnYYIL7xQGWKJfct93maxYQ5dtP6MVL8I5uwQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4051
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.66 / 15.00];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9514-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gary@garyguo.net,m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[29];
	FREEMAIL_CC(0.00)[google.com,collabora.com,linuxfoundation.org,kernel.org,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,ffwll.ch,samsung.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:from_mime,nvidia.com:email,nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,zulipchat.com:url,Nvidia.com:dkim,garyguo.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F13486FE989

On Fri Jun 26, 2026 at 11:45 PM JST, Gary Guo wrote:
> `Deref` is automatic and should normally not be used directly.
> Also, `IoMem` is going to be implementing `Io` directly, so it will no
> longer to be implementing `Deref`.
>
> Reported-by: Andreas Hindborg <a.hindborg@kernel.org>
> Link: https://rust-for-linux.zulipchat.com/#narrow/channel/291565-Help/to=
pic/.E2.9C.94.20Projection.20in.20dma.20bus.20address.20space/near/60667206=
1
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

