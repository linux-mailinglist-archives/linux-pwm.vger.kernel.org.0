Return-Path: <linux-pwm+bounces-9529-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rQVIM7TAR2oLewAAu9opvQ
	(envelope-from <linux-pwm+bounces-9529-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 16:01:24 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B85E4703335
	for <lists+linux-pwm@lfdr.de>; Fri, 03 Jul 2026 16:01:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=WBiR+SZe;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9529-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9529-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 56723307751C
	for <lists+linux-pwm@lfdr.de>; Fri,  3 Jul 2026 13:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 384B73D9555;
	Fri,  3 Jul 2026 13:50:44 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021075.outbound.protection.outlook.com [52.101.100.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD9E3D954D;
	Fri,  3 Jul 2026 13:50:42 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086644; cv=fail; b=ct7FUou0kpHGkZ09KgHEKXTrjvLN0xRitIaGclqqdFkx9OpQ4vXbXdZVjI6RyADQzJ33OafGd1a2jQMG1qCvPIx2hcWfOESOetKlkohAu3zuq4fj2ktvhmo+H54HPZnDd6DaaQr0DcpTc0FdnrqEvOcpOXs2T7LGTGcXGRKIA/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086644; c=relaxed/simple;
	bh=NZAvD5++MK+D3+T4Iqx9xOb0biN9XQi4L8VxGCFSRZs=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=KbH1p5wBGh84GH4VXoOWrelDMNZ85EHilxJ8xj17znA+Q7yqh3lhUa/+5kkNaKsE41VTTw/SG2r+NwNG4CSmQ8S3ljjiX9W7pJS2B4Lj154wayK8VmCmlsNtkT1vZbep1QH8Ju7YfAsiOf1xPqdqubt1hvbsOw9po9YaHsqI5rI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=WBiR+SZe; arc=fail smtp.client-ip=52.101.100.75
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkf/gYSjYqiS1WOonoyfeg6ZKtnR7BBlgwJBZ+omZ3Mh3L9lEkqWzeDG3aDOACY/KXBG02DMN29eak9E1CLemd13c1DAnG2PC31rRUlzDVei3SmgQPQ4J9/tTVP56J5Bna1SJ62YizeKgw/b3gSqLPULyaSDpTf81MPF9de8Ci1hqZCv8JJVoqJHhtG9LJIZc8zf83oDBM3kzPGOick338el8myRfvTLhC5vssR7zhSeqLRgdxDN+kY/+lCzhoAT+IH/b2sw5MkQjFi14aHIS4fcefJN5RATGGc+O10Sv7g1jA/pPI/L6nbKAy4BB1Mj2d3Z3z38kOZqiNbkNcALdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZAvD5++MK+D3+T4Iqx9xOb0biN9XQi4L8VxGCFSRZs=;
 b=YuRnRTBVcScpstWZ5MN16/Bc//Vf0QwMplS4EmaOtxhqE1+/guIPibl3vBaa6D4hiCVtuiohOm7K0yzUqAPLowgfXSQjwu7NQrSPutURhlAl/KQEMHh9iJFVtbmg8UK8utFCNZDWq3XNbvmw8TToljhaQ/crtZG9ZSNGY/4VUnXl9V5uTdv2Pwguz+0v4jJyHMwQiH+hj6fq323ForJT8lMpLV6zEBFzHH5OBNQEQc3lUe7V6vFxjU/g2wywwLl4h0vHFdPaWL3h1hfCKQG14Zfy5rtNtMZmyoYIozFnMFCc2enuxaZT+xZUZstZFsIJTGh9HkpntjSPTewHKj1ceA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZAvD5++MK+D3+T4Iqx9xOb0biN9XQi4L8VxGCFSRZs=;
 b=WBiR+SZeSvzAq60YXB4Ab0ORMTKPGUtoxKLF35MMVsLe3LTdHMBq/c2oRWhYui6vNBxKHFk8GCPuaccOFs6lFWNKH4Xt0tcXBkso0p1K9OrPBFliFPZxf6uIumy6YKMuietorJnmmjfLlSq3zZJ8fjocJBT6JEN5VKFlxMo7OFg=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOZP265MB8524.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.19; Fri, 3 Jul
 2026 13:50:38 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 13:50:38 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Jul 2026 14:50:37 +0100
Message-Id: <DJOZGKUDZ3GT.1FU4BOO0NII2E@garyguo.net>
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
Subject: Re: [PATCH v5 15/20] rust: io: implement a view type for `Coherent`
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260626-io_projection-v5-0-d0961471ae50@garyguo.net>
 <20260626-io_projection-v5-15-d0961471ae50@garyguo.net>
 <DJOYP821KAZF.IZZ0ZOF10AG1@nvidia.com>
In-Reply-To: <DJOYP821KAZF.IZZ0ZOF10AG1@nvidia.com>
X-ClientProxiedBy: LO4P123CA0670.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::16) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOZP265MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e30a60-dc47-49a1-9539-08ded90a1043
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|10070799003|366016|6133799003|22082099003|18002099003|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	MXLAd2dK+MUzsQplutL4JWVfHm1GX9Eu62HnWvpVhTotVfgjZrMli9VePzD9RznAAqe8pCmk0i7+8ayQriJQGR+syvyDNJArdtemVPce5v5ECBn0gwVnJMOsN/CN4HiNNr/fn1DqA3f/8C74jba/sBTIZ011xh/VlcQ2BOHIcX7O+yQmmGfzHquE4oihBz3Aosv2I6Pz1X5Kh9jQ23JG1ksw5Wv4TIjNOfrrEoQ+VucTjRWzmueaV/h1YfSS3br6GA3bV9ClDbSCBpt7lIyYs7i2m+Ca8JdXIWoYlzL5SYnnvQjAkOrPJYg6zGnPHM9hrOPwuBVOP7wHwLdvzMa5mn9qFBp/rihuFAw1D08AXxFbg/8bVSFeOn8Cqkk34y9xJsgu43Bt6JWv+vrPNPo6fNDVvvVpbNxxQ7znIW2wu6RTEx/waRNNnpwRMb/QahhAM3DDbv9zsWvNSdMuonXrxJRVFFjsdDK8cUH9cGFw1zn4jlfEN2fe9mfN4KLV0lK+v6iASoqh8Hlh3gbT9DGrt8wpnU1YSZXr+WLnuw/6raV2p0GWMHfKF0IKncJm3c1fNXpoMM/2wgfXi7nS6RizB6HbXNrnpzWH4dUpAt0dYeXslfkIYzD8r8urNYDDx4Ywa9hnnTVJH1kS7JQwlDeCX4PtaO0M+4CDjDPIhBFllPM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(10070799003)(366016)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y3RrQW1nREJOQ2dqYWpTZ3NDby9LdzdzVnN0MDlvK3dLaHhIdHg1akVtTTc3?=
 =?utf-8?B?T3lHNzNvVmtDRlM4WWpJWU1iUjlZdUpsS0hqVHB4eWNwSUx3ZTZIUU5aZFU4?=
 =?utf-8?B?NTZYZ2hFRkVmMmpRYTB1VmhvcnhveFV1SXp4Z25BRnFNT2dCeDlCbjJHUWp6?=
 =?utf-8?B?L1BnYUNKcXJ6WW1CRExIZUMveFV5a21RYmMxdDMvNGVkNDNLYzduN0RqSEdo?=
 =?utf-8?B?Sm02dG9GQkZJWFU3cEFSc1VaRGtpQnBmQnNwejBUQkF4a0JtQW93VHV1MzZT?=
 =?utf-8?B?NVczSE9QOGNOL1Bnc2t0bnJ6VjJ3OStyQytxVWFlOFJaNXc0c05PbVVxRXUw?=
 =?utf-8?B?V1g4SWp2RFJuNmh0WmJiV0ZPLzlLb1lnb1FWUDFsRTVhS3FUc0FwZ2lJWDky?=
 =?utf-8?B?c2M1SHNyOUEzL25JRlk4SEwyMXBpU2llN3lmbjdVRTBRZXh4WlFTVmZnQVZC?=
 =?utf-8?B?MmE4dXByWHZwTjdIVTFNTGNBTUxOa0E0anFUdWF4WEJOR3NOWlpzNWRWelpk?=
 =?utf-8?B?b3RPNmxrTk9aeE1aTDk4NUJBaC83eExzcXRGL0l0OHRmSnlxeVNFM3pDWUZj?=
 =?utf-8?B?dFpiaEJ3VXp3L203TE5WaDVlQmdvc0N1dFd1ZzhEMUEzNC9CTmtlUUE0clEz?=
 =?utf-8?B?SzNJOWRUZWdpVGg4TDc3R3RETEpWVTRQcXBuYzF2OENNeTlpMndOWlRXUVg1?=
 =?utf-8?B?aW1telErMERHc2hBU0dhNlZ0Nkk5VHhYZUhaTnhjbXM5ODNjSjhaMnlWdmlz?=
 =?utf-8?B?Q3ZFOVo0QlVFRUkrdkRWb0VkTjFxL3c2a2txSDZMSnpSK05LK055bUlsU1N2?=
 =?utf-8?B?dlkyN3dIb3NLVWFVa09ETzc1SmZrd3Y0U2JNSFN6cVdPZlo0b0x0RzZ5azJM?=
 =?utf-8?B?WGkyWTZZdmNsanhpV1AvbHFMeW96V2NSRzVGQWwyUTJFc3FTUkRvQUhaK0Js?=
 =?utf-8?B?bnJhSWhzZnoxSmhIOGx1RzRSdCs0dEtHaTVIcDBRTDdXVjhEZjNsVTJtMW1q?=
 =?utf-8?B?anhjeERjRnc4dUs5M05keEJzTGtJb1B6USt0MzV5ZlNNWlhwNzUwM0FRRUlU?=
 =?utf-8?B?QUs5NklTZEhOdTZyQTJlYUQ0WTNDOGtrbzR0aHl1V3RYakJiYmE2NHBTUnAr?=
 =?utf-8?B?Z0RmSWZncWk2RkRDcC81ZHo1SjlsaE85eXA4UWU3UWxzbHFCL0JpaitETHFG?=
 =?utf-8?B?YXVoSHkzclA4NjZKNFVGWVZjM2xSb01MTVVrNjd6NUF6YjYyNVNKNWlnaFRU?=
 =?utf-8?B?WS9PRTZ2UkQ0dDlUQS9Pa0syNm42TjFyKzQ3Rk5iZU1UWHBjUWVFblJMY3N1?=
 =?utf-8?B?c0ZVTHlIaUowWDV5bWRhMUVRd3lwWDJ2Mnk0NnpEcGhXaEJUUU1vY3lVNFJu?=
 =?utf-8?B?QjdiYXM5dTQ2dXJjSk9VcDMvKzNVaTU0TW9DRlVmWGl2c0ZiRXI2SG1QbDBv?=
 =?utf-8?B?VHFWVERTRFh4Mjh4ZmtaY3BhdHpseHRhTEZ6clNMVTE2bXhVdWRHMnpBNE01?=
 =?utf-8?B?cDhRQzU0MDFoMXN1dEYvdDN4UWZoVmxab09PdmdCU3l2Sm42dXcrc3haRXJs?=
 =?utf-8?B?d3lsYWhtNUJMWE1kZlNZb1V0UlhZaW5RN1h0TGRGVUZZMXEwK0RuMVU4NEx2?=
 =?utf-8?B?R3FlNTMvZmEwVk5IU3JkRGJ5U3Z0bXF0a0tWcTNVZ09uWjl5QUsxQ3loQ1BY?=
 =?utf-8?B?Skt0ZFlmczdhamZxR2FVTEszcDVsa1l6THRmS3pFUlRGRk5LcFl2cVg1elJy?=
 =?utf-8?B?TlZLdjZiY3E3b1VqNmd4WGczcGp0VzVWZmZLOXhpdUorZi9zMHhMaWFIYmpP?=
 =?utf-8?B?TnM5YmNTN0lzKzZIWTNacllsdGlmSVFsU1JsNzlMMGtBa3dPZ1RsVHpMVTBU?=
 =?utf-8?B?SjFFcFdhRWNxOUN6b3Q0VStPei9wTXYrRVNhNDVkTlhGaDVFa1JLdkdwSW53?=
 =?utf-8?B?NTkzWkZ0Z2VmQXdOMmEyK0J1azNQMjBlMkNUeWw1M0h2dmFaVGtSMmp6a0dp?=
 =?utf-8?B?ckp4SDhzc09qY2F2MXQyaytnZEVqL2J1VHZHQ0FBYzJuMVV3L1lkejFyT2hJ?=
 =?utf-8?B?TmRrZHc0WnplTVpWL0ZGU0tEdHFDNXZLOU82REoyZTJxOHZRT0wvczEvak5s?=
 =?utf-8?B?c29McWJ1MlZHenFQcVp1M2U0WStleWduTEJsWHJSWERCaEVxemVmUnAxVDBw?=
 =?utf-8?B?ZnJaajNsa1hwdXRXcDBXQWI2Y0NMc0lPUm9uTVRMMW11UlZycWJ0QytUNUQ1?=
 =?utf-8?B?SmRNU00rUHpJZDQ0RUx2MStXY2FQTU5HQURub2RJR1o4MW5CbXl1TExQN0p3?=
 =?utf-8?B?TVhpRU4vUUdjU3I3d0tsNjFSaUpQNFFuQmlNMEJueUM4K2FMUGFzZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e30a60-dc47-49a1-9539-08ded90a1043
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 13:50:38.0121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: InFNq6dKyRSPs5PTZRGlnYudNm02aNULOqw8It7qJDq55XY2za/1/mMY0G2BSgG6x128V+fbh45ASrLMHyfyNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOZP265MB8524
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[30];
	TAGGED_FROM(0.00)[bounces-9529-lists,linux-pwm=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:acourbot@nvidia.com,m:gary@garyguo.net,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,collabora.com,linuxfoundation.org,kernel.org,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,ffwll.ch,samsung.com,lists.linux.dev,vger.kernel.org,lists.freedesktop.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[gary.garyguo.net:query timed out];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,vger.kernel.org:from_smtp,garyguo.net:from_mime,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B85E4703335

On Fri Jul 3, 2026 at 2:14 PM BST, Alexandre Courbot wrote:
> On Fri Jun 26, 2026 at 11:45 PM JST, Gary Guo wrote:
>> Implement a `CoherentView` type which is a view of `Coherent`. To be abl=
e
>> to give out DMA handles, the view type contains both CPU and DMA pointer=
s,
>> and the projection method projects both at once.
>>
>> Delegate most of the `Io` implementation to `SysMemBackend`. Provide a
>> method to erase the DMA handle and give out a `SysMem` view, if the user
>> does not need the `dma_handle`.
>>
>> Signed-off-by: Gary Guo <gary@garyguo.net>
>
> Of the Sashiko comments, the second one (adding exclusivity requirement
> to the safety comment) looks actionable; with that:

Most of the text is taken from existing `as_mut` method on the full `Cohere=
nt`.
I think these can be addressed, but I'd prefer to leave it to a further pat=
ch
(perhaps as a good first issue).

Best,
Gary

>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
>
> (one nit below)
>

