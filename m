Return-Path: <linux-pwm+bounces-8955-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMhuHwkpC2q5EAUAu9opvQ
	(envelope-from <linux-pwm+bounces-8955-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 16:58:17 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1454556F5EA
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 16:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F2A3300879C
	for <lists+linux-pwm@lfdr.de>; Mon, 18 May 2026 14:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FC1036B044;
	Mon, 18 May 2026 14:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RGrkBwty"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013032.outbound.protection.outlook.com [40.93.201.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810EB371053;
	Mon, 18 May 2026 14:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779115381; cv=fail; b=DtSeJf6p5q/NsRXR3ndES+EC4zx2YpMJ3loiRZMsg2WRTrJdDFhL8g87uZ3CUiBn9WkcaWCsGf08TxmK604Cv6MdxyTJMWbOvzw0FRxcVUtuxmzd05la3BAIvPazuhT6vnNFGGF+JYrojiovHWLuWHWn8Z736Q7dsqN1iwZ0UCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779115381; c=relaxed/simple;
	bh=TFwmaYeDnaNHIqFoI7sV82Gs0z0KbjMHRnror54Dp/g=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=Oz/qSGpvMYgh0EL8eOZ2mFKLG5nJsBBfllP2456Zm268SYOhgyZZkuF9dcHySLU2gDargWOdQ6mpRK8G+9Oyi2/n/AK9Dr1DLOZ+0KaCkQcGgPxut8NnAPJB1ewakFIKDy3E2+rbZfp6dxX2XTOj5F9pOBqlS5SuPAiYizlBaT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RGrkBwty; arc=fail smtp.client-ip=40.93.201.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDlsUeRIQ+HRRsHS0ViILMs45y4ECW56uyBH4auz1jsxRUwnb0xdO5lkWGCEaD/xRqmkFPBImATHLulwBdlP7xNnvRWOY/VM8gF3Np3oy2QEIkgMjWYmAiewwcx77WWw1N2Ay6cSVtWJz7+wFz38clIEbsMGctoTz4xen8iM/431UUwCP/VKvCm2305kmOpUEyFQ1hrVRp1/1pZgTZuNKltQ08WkjIawIdHUCsvG5DjeG6QF0/OFaE2FGMR584BodjW+0m3l9dMKt+mTLgQO0AYLzb0+jII8r7IhbwdDXaQ6M04D74avJGJKSSoTW171WSg7Qr9O+etSCG0hmXffcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFwmaYeDnaNHIqFoI7sV82Gs0z0KbjMHRnror54Dp/g=;
 b=gN31RJy7CoMMyTJxBv/QhqugFQpPSBEMMqwt27DIn01OpUVHGOFwhZjYcBLr2bRtkccu0yf/z9R1KMLCsaNfJM8P+ptXuZql8RgIzUNj0eUtpgSdpWarY8/7AI4tZdrJIbpW7L8mZUJdzexLRR9oQJMQrwgriEIvDKqDJ3FZj+7emECslrIyZSrqjGCmPwBpZ7vcfZm3u0oXY9EY3un5D6brXd+EAdCuU7/d4ZLMsEBoDjOxUZm79iipwtr2xnfAhwjk206L4yR6IdYZWend7eDHuI2qnYEN2QIlOIC1wJZl3WEVlXL/g+HwHE3Iq8QIBETrroXFdVmNJxel2K4hWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFwmaYeDnaNHIqFoI7sV82Gs0z0KbjMHRnror54Dp/g=;
 b=RGrkBwtywwnBrIApYDcmf+EwCX96exdTnbMkWbXo68B6pPJES+pck+z8XDgvcEub0ximOLZMX9ubg8GgZXGH+407IVLF3RHgp0Yhfi7X+7u06a0tRT9wEMs4fpG1qRhBVJmnEZFrtUtLuf07BrWqEUk3TBVsobvETc9E2RlIP7rGU+Wsp15V77+2JNx+POWH4wv5Buu4bj47q0YPtwuFHSvz5hE2XYNhVscszk54l4GqctBB9I90a3ECzkDXlnXPecZLWW33mMkTzgu5YWu3Y6seZ5r+I7vqF01Aq71xZQZlPuyRM/3Dgj+w7gaKuXfhvq4E7W4HmX1d7yFHwtaiaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Mon, 18 May
 2026 14:42:51 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 14:42:48 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 May 2026 23:42:45 +0900
Message-Id: <DILVRFJWZR2H.UHBNBE1QUYOA@nvidia.com>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <aliceryhl@google.com>, <david.m.ertman@intel.com>, <ira.weiny@intel.com>,
 <leon@kernel.org>, <viresh.kumar@linaro.org>, <m.wilczynski@samsung.com>,
 <ukleinek@kernel.org>, <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <markus.probst@posteo.de>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <igor.korotin@linux.dev>,
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v3 01/27] rust: alloc: remove `'static` bound on
 `ForeignOwnable`
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260517000149.3226762-1-dakr@kernel.org>
 <20260517000149.3226762-2-dakr@kernel.org>
In-Reply-To: <20260517000149.3226762-2-dakr@kernel.org>
X-ClientProxiedBy: OS7PR01CA0284.jpnprd01.prod.outlook.com
 (2603:1096:604:259::13) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH7PR12MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bb6dcc7-dd7d-4091-f579-08deb4ebbb2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|10070799003|22082099003|56012099003|18002099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info:
	FUBmlGX1PgDVRcJ0QGSNRmTq2FEKg3uDyY2Az2N0aG+vjnEJrUzsUhAoICe6OD0qBOi/A2qbeFuRd3x74QMJ1pXjMx28BETszRPj0Y7iQ0PIdQdPqC3rSKQufYKQdnrxgHppnOlC5MMN23nOMVgKg9Lw3XbU1hEom6ywT00J3GJV88VsWh83f7SHXql2kxGeQ4ITrunNx92zS8yklMvyRu7N3DI8w/XN9huJyzZ1/418eirt88llPu4mjRGpnycSDqC4+5b7sldhorbXX3OukhTh98axv0s5z5wPLsyfHP03hQWz4GsVYFylHqnAJOhKLAOQpmTmZdL8dUPg/6HGRifLAfoulqd89F48LqfnXgTqEs6PKBYI+C6EVxAEd1LjdqTteqgZaEdcGzQSzrYF3OIdelcUU+oQDlDJ3g1EDPBfoHyudfjCjDSziP+pMrZ65ZgFGtU9oTo0JWgj+C2XY+ZxPx7l65KxwXH2ALG9fe5/FV4cCaGr8FEZPk2LsMgh2nj14bSQg2Fr1dusUcH2lX+UDshNeiOnGuTpf+XHYTjT769i6g1oDSV0/ykwGejh4lq3seQtQNKJH/XrB0mq5ujNEKAGnvCTvfPZLnm+hLH4QAisestm3HkHYRoc1YFythsnH4cyD1Pdsjzn0VPJAxDLFXvABwnCIHo6+PgJIfpgTuZ6PBlIm3Rk6yw2k22A
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(22082099003)(56012099003)(18002099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkV0WDJZTUMzeUJrNE9SdDZTaWhhTmxLWkp1cjFyQVdEZ1ZiYUtucG1abUta?=
 =?utf-8?B?azNoMmoxSVBXc0FCcTFkWlN5NmNYUUgvU0tVTmJMMzF5QTcwbmVtRU9sY0Jp?=
 =?utf-8?B?Q0pvcnM5LzNzUTA3TStENjJPOU14eFI4cjJNK0UrVGlsRHRnanRMdjFtSzFu?=
 =?utf-8?B?WlJDQTZCMmNKNytFSVdVb002UDNhUExtU0JqRGZwYWNvNFduNXhDcUJ1emdS?=
 =?utf-8?B?OEM3Mnl1RGpsUUNac0N4cUxRTkJMVVpDR1M4b3RZWndVcWlrcHg0MjJQOWlE?=
 =?utf-8?B?K1pTckRCUFE2Q2JPMlU1VHgrTG5ZL0IzK2tkQUl3Zndta0FJem0vWGFXNklQ?=
 =?utf-8?B?anpkc3RtekkxR25kQUhXNE9tUjFUVHVaR1RoaEsxblVGZTNLUUFMbm1SNjVz?=
 =?utf-8?B?a2VKOHRqRVVZb1JlcFhOWjdHMUlUcm8wQUowQUJLVUhZNXo3K0NMRXNKM0xj?=
 =?utf-8?B?eUhTcjJTbUJ1T0xBcExTV042bnFJMCtsWjZSUlRuYVJoY00wZkhqVXNjQjlU?=
 =?utf-8?B?bFJGYlZ3N1JENlROSlZSL3Q4VmptVFdYeHBXSjRnd0dibVp0M3dmWis1WWZy?=
 =?utf-8?B?R0RMTU1VRzhZeXlTV21VVTRkOWMvTllXenVSYitpUEwwMHZ3THcvbUdxWWF5?=
 =?utf-8?B?QWRHUWZhK1lWR2tBK0Zqa1NXQVpxQmR2cWxpZHB3UEpLbktOOW1RbjA1NnJG?=
 =?utf-8?B?enFwaVhDblp0R2FJVmJRMFhUUCtIamlVQ3JQa2FHTytCTm01cGxTQUFPcWI5?=
 =?utf-8?B?SDlncWsyaXZHaWNjcWJycUI4cVcycno2Z2w1Wk5XMTRFeHY4ODhsVjdFRTFo?=
 =?utf-8?B?TGRiaTFqUTgySWRXRkJEcXhLMUZmU2JoSlBwSzB6N09RQndSQmFNUXZCZ0Y3?=
 =?utf-8?B?bjNJUEVBa2xXOTJ2cUNEbGJjZXVNL0gwWFVQdkhIMnpBN0NuNVYybjF5VlhX?=
 =?utf-8?B?QUdmdEFPSG9BaTA3QVlZR2oxNGlWaGlGVXNpZWVJKzRsU2FMcVZzMTEwMTNa?=
 =?utf-8?B?VkY3Um82ekdkWFEyVDJIN29RcWZTZEczcW54NjJuWDFUSzVNVWF5bFF3ZlFX?=
 =?utf-8?B?c29EQ3VXTlZtTXB4aUZuUUpEUWZJUS9YRmljZ20wcXNHYWlIRlQ4WnVJOWdT?=
 =?utf-8?B?MDdyemNOWGJWQjhWYmhybndvQjFlOU1Gakp0OFk1OWpRa1ZNK3ZQd1A2NUhZ?=
 =?utf-8?B?dElRbElKbENBUm5aa0FuZHFOTkZneG1GRE5iaVcvOWpoQU91YzBBUWZ0bTRw?=
 =?utf-8?B?b29XaXI5WkZHV1hEVHVBbkYzUVZjenRlRThYdHNLSlI1dXl2Tk1uRjhCNC9X?=
 =?utf-8?B?MEZKZTl1elBleXgvUnZmRzlWdEoyVDBnKzNsTkFNem1tbnNJUUo1OGFQNVJS?=
 =?utf-8?B?elg0am41aVRzcUVVMkpQR0tKdWNWa0Y5dGtYbWYrY3BkdUM4WnhhWmhmMmNN?=
 =?utf-8?B?Rmxxa3lpYmNrM2kvYWJiTnhHclQvWE1KSzNzbGpQTDRiMkVCTWx3bXV1YlVv?=
 =?utf-8?B?Z3ZRcVhkTmV6MnJHMWY4NWMwMk5mMTFMMGs2ZVZIUHdBTTRXZmVqSGFuWG0r?=
 =?utf-8?B?MW1YVzFKOURkOFpUN3Q5bDlzaEgwOTFJa1VGOGNmelowVTB2bm1lWTQ4dVl4?=
 =?utf-8?B?dVJlMHF5N1lLc004SlZtbnFkeWpIRTJJYWVBL3JjbHBjdEYzZ3FZK3pNZmM4?=
 =?utf-8?B?NGZDYmNEN1F6QXI2ckhVREZpRUN1Rm5UM0xHbnBmclhmam9JY1NhRndCYWMv?=
 =?utf-8?B?RWwwWTI1K3hEZWNUNGFJcEhBUUhBWE1JWE9JeHVOVmVGaTBkQWZHbExXU2t2?=
 =?utf-8?B?L2czZjFCK0xZeVlvYzl6TmFZVUpDSFVXc2ZPakM1aXhqaTU3SkJFdFpDK3BF?=
 =?utf-8?B?WFhjR2pIZWVpYkg2dWE4ZWFmVG9jOWJNSGNHSkNMK2lvaXlvR3dTTGI3c1Za?=
 =?utf-8?B?L2xUQmg5YWlFWHRxZkd4NEN0dFUrb0pTZkpkdU96MnNMYjRDclRXb0R5bTV6?=
 =?utf-8?B?QmVHcHdSWnR6NnpEbEFGdE1DSnF1VG5INHVtYTJmd0Q4NlpPZmtNOU44UjJX?=
 =?utf-8?B?NHFCazdYQUxSOG4xVHd0dnF4YlJBYTVnQkNCTVRTQlhTNVRHQnNYWXk1QVky?=
 =?utf-8?B?NTcxT3BENDlSS3FvNjI3SzV4b1FVSHRJc3BFcFVHWHR0Q0xCd1FTTnI2dmoy?=
 =?utf-8?B?OXRleWlubmZsNWNBWElNTEtvNE02TmJZUktoeU9WMW9kcXA4MW8zUWJFeWdK?=
 =?utf-8?B?UFJDYmczenl4UFM3TENmRERkTjExYXZhL1BZNnF6RzhZaS82UGpPRDdQZWo5?=
 =?utf-8?B?SmZHbjl3bWZZWFpkWVhzUjdzdGdscVhQcDEzM2hOZGFrZDdLSzNibVhVcGRo?=
 =?utf-8?Q?tMRAZqFvzNmXuM0VLRytzv/jclH4QfAxFPi79uich3jGt?=
X-MS-Exchange-AntiSpam-MessageData-1: /iIrFWI0Nzz+ZQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb6dcc7-dd7d-4091-f579-08deb4ebbb2b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 14:42:48.7743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vWM1Uz28NhO65epOj9fm7GgQVGD/oQjq4kDvcCtSJwL7AST9iNncTqiWZkXG4OLp+IlN+BZ67FQm9EQCzh2srg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8796
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[33];
	TAGGED_FROM(0.00)[bounces-8955-lists,linux-pwm=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[acourbot@nvidia.com,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[garyguo.net:email,nvidia.com:mid,nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,Nvidia.com:dkim]
X-Rspamd-Queue-Id: 1454556F5EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun May 17, 2026 at 9:00 AM JST, Danilo Krummrich wrote:
> From: Gary Guo <gary@garyguo.net>
>
> The `'static` bound is currently necessary because there's no
> restriction on the lifetime of the GAT. Add a `Self: 'a` bound to
> restrict possible lifetimes on `Borrowed` and `BorrowedMut`, and lift
> the `'static` requirement.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

