Return-Path: <linux-pwm+bounces-9175-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCPeIHnzFmo6ygcAu9opvQ
	(envelope-from <linux-pwm+bounces-9175-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 15:36:57 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A8E75E5110
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 15:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06F023019BA4
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 13:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E1B40FD86;
	Wed, 27 May 2026 13:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="f3aVwVfh"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021097.outbound.protection.outlook.com [52.101.100.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097903D47C3;
	Wed, 27 May 2026 13:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779888654; cv=fail; b=U0dkMo3m1bsFvSi9BrJ5hCYcq3iG+jqHo/LMvJzjJU7SpjITG1F/a3/S8EoNkS6lmTKTkyHlfbsOvrz/Y5GyBhImC1usZfwJzLT2pjC9z5AAtUN3xgVYxoVMsECyTCrZzEvhumqqfvalbY91V+Ut0XcYlwCIutqHlKV5p9wqlkE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779888654; c=relaxed/simple;
	bh=feR2VNp8vGz8G8G2g3JsD0PKHntaYAaIS+oHaifhNDE=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=pLT+v+eZbXg6BIk/kqstueoBOmBmZ2VqKRC1TwDxhECOxGZ7Qf7nzXTfqupyFv4eq+KM/k6zd/LcfVxHO4iISb0hjA9FxsArcW+vhAxCczH20bligpwlBRctpwwFNHXotksyHAhruvj5Uhln7YIwiTGDCWUQVA+WmXsl+L6Fsb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=f3aVwVfh; arc=fail smtp.client-ip=52.101.100.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwSKXPu0NgNWAwlG9rxW4hyOSVGNjlyRWJrYXWdJ7Z6jhj85gkWB19j4Ngupw+e+OJTrkBlf6RlpAUYl92o8+0RlFRKDtmkFBkRII1DtCwFcjmhO01wddOovWe1lzbwnzdwwc3NsxDWHlyh3nXDXswU89kNm7b6w7lAsfmSkghC4vajl2JeMiVchip++MBMJIZNKZmR4TbqPV4NihDapHxuxfgKy97DAKG7pY+wawrYaYtlVsOkYODy3JVwAq2FYVzoXXhC41qKDTUgq7geUCsTszvdMYmgdvNK5+t/fnRsCsje+hSs8azFm5M3PShUTqHoR8GE1BO2LVOssrTeHYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JpZmkxCsk3M/5SSeW3RThlrYW+o8eRvavcXBfQgiIn8=;
 b=RCk4RUEI9OdeDrGfAdW3Nr9Jbg3h8QqJdyE0X+tmuym1a2DBKJvARzhImPvFGa55qSBwQtzpTHKZhdTiYGZPQPVbfbI5xBGXn8CZ/1t5ygqKWkd3K/t/QLP9Nzru7/Et9Q8q9Lze8egjn7/nrANi6Nze9Bd5Yoc89E36hauydKgOtp1aOfsXHVm21+3xarRE/Abu0tS1wDD4feUXHF8945L9yiNttUGTY684Neqva3N6QFNf3zEB8bKpanZzOHzThPwXAsNlhH3A3EM/kPmmIcEPZ4Gt4lB2Rox/0FnUaNYeQwvalT10fZCpOVa1sQP2LdgJwodSxU3+CJlmwa6Qcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JpZmkxCsk3M/5SSeW3RThlrYW+o8eRvavcXBfQgiIn8=;
 b=f3aVwVfh05rIBitDf2ejkMXQrqUwSSpYGRcayw80OfIxq07S6hS+jUGufb7tU9AzCdyrtuPOirMoV/LwmLbdpi1Ae9upSpD8L1rAqQjBS6ZSLSFEFpTmjDQy4N7kemtaBf12pZLDFz8uMGxAojgE+TiZxkoMNoz7K4bR1LjjBnI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB3578.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1b7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 13:30:49 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 13:30:48 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 May 2026 14:30:47 +0100
Message-Id: <DITHV8Q2WCW9.15Q9DN5IFWRO4@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Eliot
 Courtney" <ecourtney@nvidia.com>
Subject: Re: [PATCH v5 18/24] rust: pci: make Bar lifetime-parameterized
From: "Gary Guo" <gary@garyguo.net>
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
X-Mailer: aerc 0.21.0
References: <20260525202921.124698-1-dakr@kernel.org>
 <20260525202921.124698-19-dakr@kernel.org>
In-Reply-To: <20260525202921.124698-19-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0604.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::13) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB3578:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d0ea0a2-90e1-4a36-0434-08debbf429fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|921020|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3pGBBaVlFNr/62AGvBvcjc4o4ZhiPOMBjdpzvIFB6pSB+r9T2wxNze/bqhct5ZzYBULCISdynMjCRNGobSmMOb3BJ4VDoHtErU7ZgJqoLPSb4ppoC/rjpKvEyerhieBzNaIMvYi+RFNloNrigJY2pXtyN7FZZdovAJEOOPt33iAR6t9w61icL84cnlaxs0yL2NCFXh8EhMiHubF1Vp4e8/C/3K6C9ks74n1isZcwcPuqOj0wFktj9J1KD7ofIFkBRxLWV+HsRcnHQqGiew+1dJDwuzvj86+aY2950bjQ1pVAJ8dkJLlllEIfC1BblnYeneH1Ny8oyE9D8ou0k7UC6py7/ghgGUCa5GcuuTozs6TSFcFOI/M6EEBCKthG8xcqGPvKd7VD+DmJiW4qwTWvCY7Ne56cEcMo9wKuy03WMYCXUgeXUhAoyQJ+EpVgX8N9K2oFFr+hkGygc6WzyL31Y7ZWTEZN8ETL30PYdqv+Aehqh6HP6Gi3iUeFTurPVY+h4qBck+ZiEKveW8MFpBpHzbDBAjjtoN4suR057iJ8oxr//+rxVDsIqBogWtgoYmOG2p/xeL7J1pTbc06tNbAxgj9JZ4AO7EqhSSYCA3UfDxPjL3EnPB2kwb6K3qM8s60VFLqZpj8pXwQrRyap5V2rBSxUTbKcThwN2F7zo8r8Dy9P+AGL0OSTS8aXcsOl7pIa0luRj7L9I2vJStTAwAW3L+R7gfUdAr2OKs5pmugHt4E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(921020)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlBtblVPbXRSOVE0MTBkNHJXVEpWRHRHK2lCdGpZSk9XbStoakdpWkt4RFV6?=
 =?utf-8?B?alpTKytHcGZveU5HczE3a045WXlUQTFSaEg0dzNoc1JTWkd4UTMyZUFVUVpy?=
 =?utf-8?B?L1RSd3JNTGJBTXIxQkxlMEhGMkh1SmMwY3pvZmFBeHMvN25PMTlJQVZvR0xq?=
 =?utf-8?B?UEk5TzJISzl2bjVUZ0ljUXh4RC9BdTkvd1lGbFdCbHdjQ1h5WDc3b3VhUU96?=
 =?utf-8?B?V0FHVGwzVEdNSWJxZVc1Y1JjWUhHMjZaQVlWSGw3RkhRTkNvQUJMWjc2Y2tO?=
 =?utf-8?B?Wm1XcWdBQm5pdmdCMmYxd1VkdnhLc1VhNnpxTFVTQkhNWDlvR0R5WWtqZlRj?=
 =?utf-8?B?QVlaVVpaaCsyWm01ZlBqSkI2SXBzUWdQSlpKWWlBeUpILzdnclJxQmh3UDlk?=
 =?utf-8?B?ZXJ3R3lZQW5uU055cnJlaGtCTDcrS3Z1MUJWeDBoWUQ1NjdsWGo4UkZxZkhr?=
 =?utf-8?B?a092T3haTHY3a09BY2dYa3VrSzhQcG9YdUVaUm4wRXJPZFM3RklXMHgzTjF4?=
 =?utf-8?B?ejRnbkIzUVo1UFFFVVNlMkgxUmdIdUJQNjZzYUJ3Slc0U2JtSThtKzJER2xB?=
 =?utf-8?B?R2Nkb012SmE0eldUbmxWdmIxbkd1M1JKOHE1ZkozeEtha2VUZmFuRjhHNW1k?=
 =?utf-8?B?MTBMN1ZNSXJ3eXJQMEt2U05KcVE5WUc2Mkh2ZGMvMmVndVU5N2ZDemNId0Rr?=
 =?utf-8?B?SlZPQUtQV045M2h6ODVIOVFsbE82bmZzKzhkdk9uZ1orTEtLLytFOCtDQzM3?=
 =?utf-8?B?eFBLS1BiVTFmem5UR0hSWUdRTnVnbVdEa2VpS1FnOEJyU1pmYzFLSnNXSTlK?=
 =?utf-8?B?cVd3OHgyTXl4R2JVeWZDYWdHalpKeEFlcVNvWStFVndBVVJqTVZ0RlJqdjNy?=
 =?utf-8?B?K3hUMEZxeUFuVWpRRW1zOWlPSlBrdXJ0OG1YKzRkVVBZeGJhWWRLMXdJa3pD?=
 =?utf-8?B?bFlLcE94OEVoUXN0cDVjcmVHK0VkWkgweHRMeEZrVnAyVEJQT0VBdU51OHpm?=
 =?utf-8?B?Q0crSHlSaVFnWUF4c2pTazF0a3A3Rk9pSVdiN2xsVXBIMGFzUDIraFRzMVFO?=
 =?utf-8?B?T0FRN3VpVFgwUnRkVTEvTHRzSi90dWIzOW02WHRmU1grc0YrYzFMQVplcUdm?=
 =?utf-8?B?OGtlcjI5aitCOFB4aXA2ekdMNGwvaWFpOEc0Y04vbGZ4aUd2VStsYU1OYWdw?=
 =?utf-8?B?U25GOTY3UUJxRTYzVkE3VE9nU0ljSFh4L2FpNW5aWnpuNnVzRWF2ZnlpSmph?=
 =?utf-8?B?VjBobEpNTm80TDRDRis1S1R2cHhiMjcvTnp6YWdYR3pwOXYyS3hiS1Y2MHY0?=
 =?utf-8?B?WHhyYW9pOVh1emxYS0hSMEJuUUMxUzhCZlBOQ1NRZjIvSG1SNlQ1TVdrK3Nx?=
 =?utf-8?B?aHBYQU00L0NKMXBEMVVqQkIvYmxGWkw3aG5rcU5vQlR4UjRVZzhVSXRUMUY5?=
 =?utf-8?B?eUxscjloQ1ZqRzJsUTIzVFMya29qOG9YS0R1TlFnMmJxcWFiUEx5b3RiSXd2?=
 =?utf-8?B?VDM5YW5UQzJNeFc0TjNZQ0JDRDJnTzUzQUtBVUUzVnBwdWtsV2FEZ0p1Mzly?=
 =?utf-8?B?VmdjNVFXazhhc2JUV2s3b0d5ekV2cm1ZaDlzK2J1UXVjVWRDNlNiNmpNVnR0?=
 =?utf-8?B?TlNDM0FGZWhwWE1rZDExSnA3WFI4RnY5bEFrOS9yRG4vT1lGNDY1RjcrUzB6?=
 =?utf-8?B?M1R2aitNQzE0UERQR3k2cDVFZ0FTU1JNK0NpeWxNeG5DeCsxWkRRT0pINm1U?=
 =?utf-8?B?bFRGeU44Nm52QjVGb0xMazRoTVVjYU5GeE5HVW82RTUzMGNQMGN4bC9IUW5w?=
 =?utf-8?B?VzhBZnRyMTZGT1JPK1dzeGd1UXlMUU9JenBxY2xpM1pRVU5VZlY3UUhVRDZw?=
 =?utf-8?B?dUdHdVlwLyt4aUo5VFppblpZYXJXWHJmbFF3d0hxUHZmcW5RT2JhcXBxWnNV?=
 =?utf-8?B?U2tPcGcrWDFoYjdNRnRyeWxYZTdLRjNnTytWdThXTEt0cVpGTGxQMUlOaGVI?=
 =?utf-8?B?T09TQTN4Wjdqem1hMkdrS1lsb0JxbTM3ZlZ5a2t2dTlMVWw2NU9jWHJOWXJC?=
 =?utf-8?B?TEhMaWV6cDNpTzZlL1hWMFkwNStmaERWTXluazFZZk90UGtCSGZ3WG5VK3VH?=
 =?utf-8?B?ZWhqQStPMm9nVVlBcGRQblZwakR3b2kvcXpOUkt0SnZHZkxNZTRFMEZrc08v?=
 =?utf-8?B?WnNoUFJPaGJZZ0JkbVJJMUE4K0tOWGJJL3AxOTd2MlNqTmpKMFJvSjlqd2JU?=
 =?utf-8?B?dUpOaXFEaXhFa3RhVllqUjZiUHVlUk9VYm5Id2pMUE1ma21hSmdOL2tDNFp6?=
 =?utf-8?B?SmJSY1hNZWNMRFV6OEZIc1FhelZFTjdxZG5mdjIvaXdJS01WNy9IZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0ea0a2-90e1-4a36-0434-08debbf429fd
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 13:30:48.4750
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nd0CTAFF3dGsONhKr8uDNitgR07t1Crymy3IQj0YYUSl+aDMWNFqinChIZ0xmJcfHqhgXF+dXMOBkXGiyW6ISw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3578
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9175-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 2A8E75E5110
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon May 25, 2026 at 9:21 PM BST, Danilo Krummrich wrote:
> Convert pci::Bar<SIZE> to pci::Bar<'a, SIZE>, storing &'a Device<Bound>
> to tie the BAR mapping lifetime to the device.
>=20
> iomap_region_sized() now returns Result<Bar<'a, SIZE>> directly instead
> of impl PinInit<Devres<Bar<SIZE>>, Error>.
>=20
> Since the lifetime ties the mapping to the device's bound state, callers
> no longer need Devres for the common case where the Bar lives in the
> driver's private data.
>=20
> Add Bar::into_devres() to consume the bar and register it as a
> device-managed resource, returning Devres<Bar<'static, SIZE>>. The
> lifetime is erased to 'static because Devres guarantees the bar does not
> actually outlive the device -- access is revoked on unbind.
>=20
> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  drivers/gpu/nova-core/driver.rs |  7 +++--
>  rust/kernel/devres.rs           |  2 +-
>  rust/kernel/pci/io.rs           | 52 +++++++++++++++++++--------------
>  samples/rust/rust_driver_pci.rs |  5 ++--
>  4 files changed, 38 insertions(+), 28 deletions(-)


