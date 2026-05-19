Return-Path: <linux-pwm+bounces-8991-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKLyFpsZDGrrVwUAu9opvQ
	(envelope-from <linux-pwm+bounces-8991-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 10:04:43 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D344A579A02
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 10:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C2C030CA1F4
	for <lists+linux-pwm@lfdr.de>; Tue, 19 May 2026 07:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2A733DD532;
	Tue, 19 May 2026 07:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K8d/my81"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010014.outbound.protection.outlook.com [40.93.198.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3363DBD4D;
	Tue, 19 May 2026 07:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177415; cv=fail; b=VZF6ZgOK3YRwCMu27ISLfQ4ap44TIj6zbo0Iqz6r1LllMGEsvBRfGabgNuBgIYAMo89Wv/PKqf9v94ta7zRGVCJJghxiycAGej4oXJSFDzigSrFm9RydfsObAzUnMdU9qsDOB8Bvuia4IndDLcSNy9NTbWO0sRb2SFrT1NsHemM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177415; c=relaxed/simple;
	bh=GOwAIrKvLyQYd7LAM1Qd00xQWmFuloY7PcA2+Nz2U6w=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=ubJuQOsV2ySh0H0oXYZwITvv5JXkgw8XpwD+iRmTCn1U9iOP8QMptBvoXHk2w6DqoqlX0ItYLMIROpa0EYX5UFQhHwT5DQWI8YtLIwVzNK+yayHbDKJj7kIma9cXNdR66C5hEURlC6PuUDduJJK/YW9rBScTcoRegv5C8u2HAfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K8d/my81; arc=fail smtp.client-ip=40.93.198.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qA3yqXoiwmpwJrlSptTohBx/RbWV45IZqaulsbaQ4daEeXrA/wR2GfNRlixLugxcnA6T+uVUdq6Cqjnc5BYQxjIZRGuSGI8Yj6gZeHvCxof3RDt0fTaYtZhSq/XEowbVD/gC/lEdg+6kmlf0AGcv6aB1+sozocdzVhBmPkNH9JMBoEqUsAU7MajP561a3TRc0lGvs+nzdmwiXEZURpGzABkCxxya+fjl9cwIQw+qki3VDwxcvS6j8EIe9xYU/LL7WQIyBy0rOlfwBz50A5S93Tf68Jb6S/gJDewXAFfkJx0WMVuqQcH5KCx8y4cklwRH6ZNzyvvCcQH/ZjmSBppsrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xgxJ4IwLzaTyszhQpN8IhZmLl8MUpEf1tZISNg6rVPc=;
 b=hxGahSKxC8UxHbcwOzoVufnJuQG697FfvkgMFzlBfNTZX5lOLjZ5/CS+unblm6jjhr3dzJY1YfZHgjKr32mqy+cGNQ8yJHV/aaOjlOjSzn0Pa3pTmSt9nWihCDxWaMPWfjrpW33ruDJ/dsFQ9C+9W981ocYIbM2f+iRJGIwb1Djppmr+cX5OVYgHwKQcHR6jNWp5MKHbhcLwg2fAZpAYJPVLVORHmwNE+7ByK+iaaNs3zdabHfXYmbbh04VxmeWa2EO90jfIg0QppItDbMz8EIhv3hEtsjnS2XjRjAfd3mOGlanb5WUAdoG4KY6n5hpWhrD20CloLm7vLbMjWhsxAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xgxJ4IwLzaTyszhQpN8IhZmLl8MUpEf1tZISNg6rVPc=;
 b=K8d/my81Jx6D2vNrf2lfae1fg40tnORpu+ZxFgRg77eGKdhRKKRBp0UeQL8R4FqKN9QtFNI46Yex/xczkNG84v9a+DUDxpxIGMHxJT+XnETXYSSpN/y52lmYjge2J41SXmmADsEY9lX+TryzHa9GQrThBAiPSg2ptShZjxhCPcXtHXZlQH9zhOyvZ9lI7sS2JdwMmFLfpzWkJxxYG8vuBnVQkTLlDbgcbchtwIsS1sOrer8gzDJ5gPu8K7Kq1h9IAah5hBUgBzeR5nNYzTkZjFS910fFrmEYsZ08rIRSyFVfOUNUk/xCO3AOXPg1I5RbFJo0KaLCrrkvvmVqez9xaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2353.namprd12.prod.outlook.com (2603:10b6:207:4c::31)
 by CYXPR12MB9428.namprd12.prod.outlook.com (2603:10b6:930:d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Tue, 19 May
 2026 07:56:49 +0000
Received: from BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0]) by BL0PR12MB2353.namprd12.prod.outlook.com
 ([fe80::99b:dcff:8d6d:78e0%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 07:56:49 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 16:56:44 +0900
Message-Id: <DIMHR3ZPEL92.2HVZ0FGPM54MF@nvidia.com>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 17/27] rust: auxiliary: generalize Registration over
 ForLt
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <acourbot@nvidia.com>, <aliceryhl@google.com>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-18-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-18-dakr@kernel.org>
X-ClientProxiedBy: TYCP286CA0113.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29c::10) To BL0PR12MB2353.namprd12.prod.outlook.com
 (2603:10b6:207:4c::31)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2353:EE_|CYXPR12MB9428:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ac30055-e64e-40f7-e598-08deb57c2e1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|376014|1800799024|7416014|18002099003|22082099003|3023799003|4143699003|921020|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	QccTMzLd6GA+tNH5ycDTllH4+AXow1QdMm5KD8nkR+K1vetg7vGJ7DnhGrVmziABtbivPdmTlouLOitug3Rv6yfdrrFSaVYCtwmW3yr+QdPMzMK8hgVvPL76hQu4egUHw2umLWAhH87ZnB/c+lkoTyZ2RbSG7u66Xhq/HBM4wQcnWdXirr2IuYvxXfMHswAoL6991gKhncirgbUkljMtVbhKRpNfE+lb93ljeP6EFrCYCJWMPQAFuzJ0Fj/UeYbv1sAyqfakEKm2+zX/cy34h0HjrE1lVp00G6AmMIrndrAIIUgpJUuKiqOebelRwoqu7M2T0eQLTQaElse//8MOy763eZBxt3ljzckEdY5Z874VKc9AOPaHQwYogPM8r0CQ2V/JO2ZIPhJTswudLX9pSrHcntTU+Ao5F7x4/ttK/BoESO5JM8vVlONpdAUhHt72NvZX2Xob5KC7/7R7YJOy52QdeRt2kDhjePmSf017Hg+UWlDi9yfP2ExWtvgI6FumUbkRoo3h7AISZZLgKYKxs7huuGavK/Px6v3uzaw/xMPQEhIfFQGP2oqOHPPDGPcKcdGfgjgurnhB9DTGlYHP2UAE4ewi14vSGAxBTSYQEPKk3xTiNWesf2OovZCt0PG5nPswKzjHet8HsttdkX/LD38B4V+n9Qy3b5/+BvIJ79Z6QKmRz1MmFAPm4PvpCOEJ10nCv9UQ98Vkp+/rULcaI7nQcWvEyDeVyAqw9GBzT5I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2353.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(376014)(1800799024)(7416014)(18002099003)(22082099003)(3023799003)(4143699003)(921020)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c3d3VHIyNnprSERnK2ZPMEpFRFFQNTlaSG9vWWdPMXpNMTdzQkJ3U1JKY3RE?=
 =?utf-8?B?VFdqekhyRFp5M2pIOWh2YVo0Qk11TEdnV2x1TG4wNERWTjJITHFXcEI4NzRM?=
 =?utf-8?B?aVFZQktrVmkwMDVRZHZsOWd6Wlc4TTlCS3hKdmpBWE1TOGxIMTFyVlZtc2hY?=
 =?utf-8?B?V3M2SDVjWjBWZ0FHSzFsd01kallTVTkvRUZReHYwOTRoZlRzeG5VTUNVeW9x?=
 =?utf-8?B?TjQ4QTN3U0Qyb2RFSCt0eUFBL1k4dlo2d3BHYXR4UXJqYVl5bTIyb3lVTVRu?=
 =?utf-8?B?Y2g2NVhzS1JqZFlOeG9IcGJtakR4RUdXWk5DSlArb2RiTFcrUHZkenk3Tytq?=
 =?utf-8?B?OTZkb1pvalBCM0lFd2hYVGU5ZE1IdjZRMk92WmNLT1h1OFRXV1p4MjQveFRH?=
 =?utf-8?B?WkRHMElodlcrNnRJaFZFbndWRU1kR2pSTlE2YkRraGRsb3JlRHRhK3RkUXcw?=
 =?utf-8?B?ekxGSTd0QVp3Q1FPdGhzckNzUHYwSGxGYU43ZEJ3dkJuSEhNK1NWckNwTFdy?=
 =?utf-8?B?Yy9rZktaY0tjaW5CZkhBbXFxQXEvdzMvMGZkNmxTNnJjcmZ6YXNDUmJ6a0s5?=
 =?utf-8?B?Umpsd0pHbkdzSFRZbThRbzM1eFhXTUdGUHE4ZGZwL2JzTnR1WUJvaWx1cXZP?=
 =?utf-8?B?aHBHWThoVFVldzVEV2x4aGEwaGpGcldKOGVoWllqUDhMNFRNcWp2OVEydEQ3?=
 =?utf-8?B?OFc0WWtxRnZzVG1tSDFhLzlpSm1DaWFLZ2hLeHQxbjhRTm1OdUljZ0FzKzlJ?=
 =?utf-8?B?UVhyQTh3RlFyeDJETVZ0TjNxalh6enEwamNqTE1VR3lSckRramZiQWhCSVhB?=
 =?utf-8?B?eGFaYjNlNjdLcUlnbGozZ3ExbzUyUk1IcEhIb2EvSnYxU0oyMDF6N0pFL2Y3?=
 =?utf-8?B?VWhzTWZCWWxIbUQ4T1JoWXVOajdWeWx5RXRkNmhJallBdWZCY1BHbWpvbVU2?=
 =?utf-8?B?ODhaTFdJWjJhZXI3QjZ2eTRjUGF1Y2QxdzNGMnZxbzBoVk94T3ljWGI0WmU4?=
 =?utf-8?B?RmNrb2VRd0h0WmIyUnBwVk5UZ3BTZjZwcGhpMW5ubmZtZXdqd3MxR3BRd3Bl?=
 =?utf-8?B?UGZGdE0xTnp2UFNaaXl6UlMwODk0aVZka2c0OVkrQTMxVkpqYnArYzRsc2Jy?=
 =?utf-8?B?WnBFVy9vMXNiSXpmQk90Q2dNYnl0M2l3T1BKNzFBdW9SUHI0ZXVxcFFOZzFV?=
 =?utf-8?B?UGdzejhEc3E4eUdXbXZVZ1BqVUx6NXhKUEpKNjdTV1VmbHhKZEJVQWsrdzFx?=
 =?utf-8?B?VnVPNmIwMDRZaDVjWmNMbHl6eW1IbjRNaWE5TUR1Mlg0ZngyWmtZVTRybGov?=
 =?utf-8?B?a1RSaUxYYjFCeGdiYVNBUXN2Yko0TkU2Q1g2dW1Tc1RyUWZQdXU1TFBoeXBq?=
 =?utf-8?B?ZzFHMUZEZ1RjOEJoK2tuNGlsYUk3VE00eTZIODRwdkE4NUZEeklVaFZKL2Rj?=
 =?utf-8?B?NzdtMmYrZDB4bEZGZDJjaitxazdDOUtKN3l3ZzF3UmFpQncvU2JMdkdsSE9n?=
 =?utf-8?B?TTRQVVZXVzJad1NWWHhJS3BTeFJxU0N1OE00dzNTcWU4V0YwcmNod2dpT1Uw?=
 =?utf-8?B?Y0dMa0VGMjB3VmdLU0JwdGlkeHdwcnM1RENjZjJMd01LZ2tlVU9Hc2R1TERj?=
 =?utf-8?B?aGkrNWRWTnBmdXVQU2gxODQ2ZFFVRFhpTUozTGpxZ01rSXk0YjdHSEluZEZa?=
 =?utf-8?B?clZIVEM1V0Nobmw1MDRBUk45QW1sd3VBL09naERycUU3ZVRyQ2pWM01WSnFk?=
 =?utf-8?B?ZWFxNS9IL1Zab0Y4aWNscVNIaWVmME1reE56SDkrbFozMnB0YmRuR1Z0aXZK?=
 =?utf-8?B?VG1ZYWdoRk5LMGVIOWNWUnVOcTN0T0NpZGpMTjZYd2hhMVY4amRLSTV1V0c2?=
 =?utf-8?B?SU9MeTV6c3Mra3dlMDlCd3NaSko1R3hHR0lxRUJES1g3Z0tQZ2ZUYlBkd3NZ?=
 =?utf-8?B?azQxVEhFSzUySnNwR1hxMWhvWkd5T1gvYnVUYWZFOVI0YWZnTjRqOUZOUjFO?=
 =?utf-8?B?cjVFSTFSa214UEZWTzdBY2VZZlVFYVEzQVFDVGQxdE5CRzNkT0Nsb1BSNlNv?=
 =?utf-8?B?SVFrZ0gwVXJ3S2JMZzJUaXYyMldHTGlSTVg2ekQ0S3pOUnltNXlyeGQ3V1Ew?=
 =?utf-8?B?TUJUaWNHMmo0MlpIZFgrZFNJaFc3czR5OWFUZWoxcHJrd2tYeHY5ZldKQXBp?=
 =?utf-8?B?ZmRDYUZreWtjQmdNeHYwUDdhUzdFOStkNHhYclovSTZnNVRpRGVZT3VsdVcv?=
 =?utf-8?B?eTR4d2NJZzl5bEp0SzlOYXdFbzJTYWhkVTl0VElmUjVhaWNYU01KMlhoZGxv?=
 =?utf-8?B?a3JMcU5wRlFKalkyMHFxNnNRd3lJcEtXN2QrQ3plQW9VWG01M0xTL1F1clls?=
 =?utf-8?Q?U0jeTM+jkoIWdiG43pIoOsmD15gGaS/V6hss8/oDVC3LE?=
X-MS-Exchange-AntiSpam-MessageData-1: auFU/Y0FqoTg9Q==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ac30055-e64e-40f7-e598-08deb57c2e1f
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2353.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 07:56:49.1098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DLw25qw/t1HCLBu4EMNVBMYkzeqzLNi0c9oRne5+LV9GHebhEoOysyCEN1W3o4EJ6rD/TfbK2lbzeYeoMKgDeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9428
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8991-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ecourtney@nvidia.com,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,forlt:email,nvidia.com:mid,Nvidia.com:dkim]
X-Rspamd-Queue-Id: D344A579A02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun May 17, 2026 at 9:01 AM JST, Danilo Krummrich wrote:
> Generalize Registration<T> to Registration<F: ForLt> and
> Device::registration_data<F: ForLt>() to return Pin<&F::Of<'_>>.
>
> The stored 'static lifetime is shortened to the borrow lifetime of &self
> via ForLt::cast_ref; ForLt's covariance guarantee makes this sound.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/gpu/nova-core/driver.rs       |  4 +-
>  rust/kernel/auxiliary.rs              | 68 +++++++++++++++++----------
>  samples/rust/rust_driver_auxiliary.rs |  8 ++--
>  3 files changed, 52 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driv=
er.rs
> index fe4eafe1ebf0..ab0d7f2b516c 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -21,6 +21,7 @@
>          },
>          Arc,
>      },
> +    types::ForLt,
>  };
> =20
>  use crate::gpu::Gpu;
> @@ -32,7 +33,8 @@
>  pub(crate) struct NovaCore {
>      #[pin]
>      pub(crate) gpu: Gpu,
> -    _reg: Devres<auxiliary::Registration<()>>,
> +    #[allow(clippy::type_complexity)]
> +    _reg: Devres<auxiliary::Registration<ForLt!(())>>,
>  }
> =20
>  const BAR0_SIZE: usize =3D SZ_16M;
> diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
> index 3f1e2966c03a..db3d56106ea2 100644
> --- a/rust/kernel/auxiliary.rs
> +++ b/rust/kernel/auxiliary.rs
> @@ -20,6 +20,7 @@
>      },
>      prelude::*,
>      types::{
> +        ForLt,
>          ForeignOwnable,
>          Opaque, //
>      },
> @@ -271,12 +272,16 @@ pub fn parent(&self) -> &device::Device<device::Bou=
nd> {
> =20
>      /// Returns a pinned reference to the registration data set by the r=
egistering (parent) driver.
>      ///
> -    /// Returns [`EINVAL`] if `T` does not match the type used by the pa=
rent driver when calling
> +    /// `F` is the [`ForLt`](trait@ForLt) encoding of the data type. The=
 returned
> +    /// reference has its lifetime shortened from `'static` to `&self`'s=
 borrow lifetime via
> +    /// [`ForLt::cast_ref`].
> +    ///
> +    /// Returns [`EINVAL`] if `F` does not match the type used by the pa=
rent driver when calling
>      /// [`Registration::new()`].
>      ///
>      /// Returns [`ENOENT`] if no registration data has been set, e.g. wh=
en the device was
>      /// registered by a C driver.
> -    pub fn registration_data<T: 'static>(&self) -> Result<Pin<&T>> {
> +    pub fn registration_data<F: ForLt>(&self) -> Result<Pin<&F::Of<'_>>>=
 {
>          // SAFETY: By the type invariant, `self.as_raw()` is a valid `st=
ruct auxiliary_device`.
>          let ptr =3D unsafe { (*self.as_raw()).registration_data_rust };
>          if ptr.is_null() {
> @@ -289,18 +294,23 @@ pub fn registration_data<T: 'static>(&self) -> Resu=
lt<Pin<&T>> {
> =20
>          // SAFETY: `ptr` is non-null and was set via `into_foreign()` in=
 `Registration::new()`;
>          // `RegistrationData` is `#[repr(C)]` with `type_id` at offset 0=
, so reading a `TypeId`
> -        // at the start of the allocation is valid regardless of `T`.
> +        // at the start of the allocation is valid regardless of `F`.
>          let type_id =3D unsafe { ptr.cast::<TypeId>().read() };
> -        if type_id !=3D TypeId::of::<T>() {
> +        if type_id !=3D TypeId::of::<F::Of<'static>>() {
>              return Err(EINVAL);
>          }

This seems a little dangerous to me, since the caller can specify the
ForLt type which means it can rewrite the lifetime of the ForLt encoded
type to be whatever it wants. The runtime check here only looks at the
typeid of the encoded type but can't check the mapping from forlt::of
given lifetime to actual underlying type lifetime instantiation.
For example, in the next patch on the sample aux driver you can do:

```
let data =3D adev.registration_data::<ForLt!(for<'a> Data<'static>)>()?;
let pdev: &'static pci::Device<Bound> =3D data.parent;
```

and mint a 'static reference to a bound device, which seems unsound to
me. So maybe this needs to store the typeid of F instead? so that it can
store the actual mapping from forlt lifetime to underlying type
lifetimes.

Overall I feel it's unfortunate to have this be a runtime check though.
What about requiring all device ids declared to be supported by an aux
bus driver to have the same rust registration data type? Not sure how
common it is to want to have the same aux bus driver support a very
hetereogenous set of aux bus devices though. I think getting rid of the
runtime check was discussed on the other patch series adding the rust
sideband registration data on the C side, but if there's not much real
use case for hetereogenous registration data types in a single aux bus
driver then it might be worth the added safety. WDYT?


