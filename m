Return-Path: <linux-pwm+bounces-9124-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0HwZAx+HFGqIOAcAu9opvQ
	(envelope-from <linux-pwm+bounces-9124-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 19:30:07 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8B75CD623
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 19:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23BB6300BDA4
	for <lists+linux-pwm@lfdr.de>; Mon, 25 May 2026 17:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16F430149F;
	Mon, 25 May 2026 17:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="XQWnb5RC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021098.outbound.protection.outlook.com [52.101.100.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F389523BD02;
	Mon, 25 May 2026 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779730181; cv=fail; b=Zsj4yXKuYrEdC0xPtL3GJfiQEUPDPsBiwvAOiXJvNmv/GVbWcurAvFIME2xeOwNRM3HtlTh+rk2nC092B8IAnyO1V2uQQCktPNbwB/Ds6Je/NuYK2uKwV6Xe1BIR6g5A/mLyah2NhOleD9ZghQSPWPE48wbF73YBaZp3mgs3IVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779730181; c=relaxed/simple;
	bh=yXRTPbz6AssyK3I9LgWGHCaivI3bQD5/BEk8A2ucakY=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:References:
	 In-Reply-To:MIME-Version; b=Ls1naFgnByUFSzYTT5xK8nSIOdsbxdlw66/jyj9E6Mb2N8RutoNT41MN+0tY68/R1A4vRhRj+uRI5VHBzlRXw+JBEZC6GRDbuAFURcCwVDWOBYS9gxlAdFxmuzi+974q4IwpF8GrAuuxg6ZsslCisfqPnNkzuoFI5UMPaTxw0NM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=XQWnb5RC; arc=fail smtp.client-ip=52.101.100.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VspooEfrw+DbPNS/mwrUvHHhJhBn3XCS0oJKvXk/xaNjlmAlpU1y9Hi93B5agcJY4zPEicrfz5eZcoyIDgPeOYrdne2+/rhJomhCqn4dtMl6dLi1LCJx+5i9a82ZOLi+orgtaMuyVDUOQBtJVBHx3oI2s/hKu5OMfwbvvLzNFrsPjy4HQWQuHfb6stC94YemEFnjXQROkvapjRCh4JSVIVHXci5+xH5E24nNEk9aW4Cb1uGK7W6YEHIjQTi7ombd1lrOeW9ZObRKTH+1GSwihSBdzOzDtckJ0BccmH4i3ywJ8tHeyoS3MCNg27/I4z+st2vMIzgmjv73qf3ORnzTYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f7DMjinGfsc3S4T8rtMdt5DuhhY6Xu9fWq7lcEOA4Ec=;
 b=lp6h4op/uqLZWXXa1XT+7arWug9PZdy9SWijKeWO4t3fnpfemzmfnFBKlvfwa8cghsSteQ7xy1dcaokk3yGiiNuO9cNJ7uC2fw06zX47/VxCZOT0m3ToArShBGGe4hgATvm62n0eQDaiWaN0dQmUiMX+GftGcv8bcHLfzd9/dV04gat417mVnxXrrikSdIFEl2JMeCTDM6Vg/JBgOqHqfkwL+5/UjbO3+WhE4q6xVgoj3+5eRS7QUqzojX18/L5BWAvtHIvAR0NB7RbcW2+Pe2SPcko8xhR1qY1jWCZ/aPTEeCY5ner6oFcquBqeYW5zxGdR0mML9xXySGTLxS9/vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7DMjinGfsc3S4T8rtMdt5DuhhY6Xu9fWq7lcEOA4Ec=;
 b=XQWnb5RC7qFgjcPfw9FsPSdj3RRkCpChTLqpz3KZKPm0HlyTW/AwqqWkhXXZRJogYIgC8GiI8ETXZTg3w0m/g+KT4NWe6rHef4x6wtmDs1ZQOi81K/PuYTUNaWKmmYArcRtTtXjJcCJooTOkf8TpSzl4VmZIlxSbZADi9S3XIos=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB5283.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1c3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 17:29:35 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 17:29:35 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 25 May 2026 18:29:34 +0100
Message-Id: <DIRXOZ8MON5Y.2PDMFA7DSI77U@garyguo.net>
Subject: Re: [PATCH RESEND] pwm: th1520: Remove requirement for
 mul_u64_u64_div_u64_roundup
From: "Gary Guo" <gary@garyguo.net>
To: "Maurice Hieronymus" <mhi@mailbox.org>, "Michal Wilczynski"
 <m.wilczynski@samsung.com>, "Drew Fustini" <fustini@kernel.org>, "Guo Ren"
 <guoren@kernel.org>, "Fu Wei" <wefu@redhat.com>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>
Cc: <linux-riscv@lists.infradead.org>, <linux-pwm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <CGME20260525131112eucas1p1d7e4836f71c81686e1f71e4007e344ec@eucas1p1.samsung.com> <20260525-pwm-th1520-fix-v1-1-814e537c6812@mailbox.org> <8857fc45-b787-4661-b27b-8976e655f7c9@samsung.com> <1f550af5b8d1fa2aaa9936d5b0010c156e0cb455.camel@mailbox.org>
In-Reply-To: <1f550af5b8d1fa2aaa9936d5b0010c156e0cb455.camel@mailbox.org>
X-ClientProxiedBy: LO4P265CA0179.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::7) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB5283:EE_
X-MS-Office365-Filtering-Correlation-Id: 6613510e-e30c-4dcb-8d58-08deba833096
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|18002099003|56012099003|22082099003|921020|6133799003|4143699003|5023799004;
X-Microsoft-Antispam-Message-Info:
	N21Z7y9hb68lBmSMoP3P5uXNs17rUPkcSNB8YoAQktGwK1F902kxxMbJTWDyMHfEBs5chehoV6/HC5BKs0Y0NKXdYUhH2D/COs2f6zdpWQ22F4BsrJburLY711rNQb4WyQdzIDVch8plCaQ0MVKXRMQBqiI6tvYWth4q9hjPg+klJnYsPIaolILh39GSdHi82Fc1Wjivu8ata/TdUCNtDhpLV8wb+APPZu5+RzmnXHCFak4UWvFR10sv9glOTH9TdtVeLtHb1f2WMLh6yn1j0HhNXRGSdoPZd22iVEiQChnFimKO2Yt/cKfGeyTF+eriSkAMT1A/ctSglWpT4IjV5skqYfx1MwWDt3vZo1MvbfOJNoXsQ7Hs6+R5K01TUzjMxm0JJGZVRCq2WBsy83YI6FwMLW+FJERADgcOe6ia3ZSMyCgcfYeThiS86+htqUJ9+uJwiW8BN+0gG8zwSkC1GJKSIFjBmgbOFL1E/g+emzI8kMQt/Arwlwk9t37FMR2BNa3wYSVOkNGBdxLk9Y48aPfY6wFzcbbqNJfFTorbDAPUVMXAsxU1pbspJrSTlkqAqhydR4fVpXszP+GtCZFX4Ml3E7N0/ae28gD2qcmjK76GFoJ3tVA4dHuBCTN5klW7x30QA+p93eFMRzNleGakFIA+JQopGmC+vjdpd/9/C7ofY/f1akOLdEyNYVJwF/cv0v66Y5n7LVT+7Yo1FxMNxldeRS86J35siAYEDuhin+4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(18002099003)(56012099003)(22082099003)(921020)(6133799003)(4143699003)(5023799004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1lRanZKSkJHTzNLWlhMMjBnVTZkdVUvWjhlVmQraWlONlZUOGxLM1A4Qk1y?=
 =?utf-8?B?MjlST1k0QVk3ajllZTNMbnFoVk1XYUdsU1lWRkUwclNJRmtZRVhGTG1tUjlt?=
 =?utf-8?B?bkdScTdxVmFBdWd4THlhaFc3NngxOXNacmorUUtNY296TitQaEJBMTdPZ1E0?=
 =?utf-8?B?bHRONkZ6am9rQy9xL0NMdHpnNVo3Y2dJcFdVaGMxUDIvR3BjbDN5N0txS3Q5?=
 =?utf-8?B?cklxQzNvcFdVcWRjb1BCUU5FeSs0MVNQMm1QZ3o4dk12RThRM1lId0RzWWsr?=
 =?utf-8?B?L05kSjluTmFJajI0czNWVjJBczVENDZQazF3bmVCNlRkaEhNY25Sa00zcTZh?=
 =?utf-8?B?SGZZMHZvcWNzeXpBcWxBWnRKV3ZSVGFCRmkxOUkzbDA2WUp1aE01cnVyOGpp?=
 =?utf-8?B?d3djcUwzM1Y3anZZTkUwS2QyUmJiVEczS01qeDhKd21SanZaR2twSHJvVzll?=
 =?utf-8?B?LytmMmNKWGJWRDB6bHpqR0ZFL3V0bmFNR1BMT0UzdFFOZ3pDZ21ycHBhRy9w?=
 =?utf-8?B?OHBvWVgwdUNsdHFsVi82Mzh2ZVFyeVBhTXNnRTVaSXhLNkZETkpqVG55Zm80?=
 =?utf-8?B?YUhDcmdTMGtjQTdjb2ErOSt4LzZDL2xzeWlmR3hCWDNVK0ZsUzc2TGVneDZP?=
 =?utf-8?B?eENaWUpONTVCbmFFYmMzb2txWGNPMzQ5WklSNEJ0eXhjcnU3TFVyZFltYm01?=
 =?utf-8?B?TWxXSGJ3b1FSZVVrajNKNVh1RkgxTWIwb3lodDhidDB5dG5hTTV0Mm1mOFVM?=
 =?utf-8?B?elo0cTU1c0thdnN0YlRWRnAySDFtSCtQdzdvakM3QnNsMnNjTHBGd0JTRWJI?=
 =?utf-8?B?UFFPTW9hdElSV0JsZENlSG92dkVhL2JNRWpJVGJSRVU4clNxSUJKWGdxeUJZ?=
 =?utf-8?B?ZDN4aFVKdy9Db1lsNEtMS1RCclhnL2FrSm93eTY2NjVFQjFFQmoxK1dJblY5?=
 =?utf-8?B?bzFQOVNRcFZJcXFScGo2K2NOVFhTaGNNV3d2bUxmakREZVFRb29Xc2h0ZDY4?=
 =?utf-8?B?Mnh5SjgrMUdCZVVzZzAxSWMwakRXc2toVkZJQzJhKy9aN3c4QTZJb1J4RWo3?=
 =?utf-8?B?bUt4OFJsQmdJOEphbzAwZXkraW5sd2lhdWVjV2xMRmhKc0VidkIxT2NhU0Fi?=
 =?utf-8?B?Q3UwZ1BrT0Y2QmdneVZmTzJuM0hjYlp6OTdvRkNLcXV4dE9JYWN3Mjh5ZXIw?=
 =?utf-8?B?cVEyQVBJWGRoNDVRZjZnWEdjWFZvbzExd3FXTnlVWlVQVTVSM2pvUlJRVW5F?=
 =?utf-8?B?bVlqRmpiTnNLN0pvbGZUR1ZTTk9DanJHb1JIeUgzU3ZFRFJZSlVnb3hRS216?=
 =?utf-8?B?Q2hrb2tXTHpEZ1JtRSs4d0crckJTTjNOVy9IeVduYjVJVEpuMUVDdjlsNG9l?=
 =?utf-8?B?Q1dQVVZwSy93QzBwSElLRWs0VkhpdkpINmxiQ3I2eCtDRHlEYkpUbmg3WGZY?=
 =?utf-8?B?cUs3aXNicHhzSEUvSzFEeHhjNWpDUVhRWlM5ZjdULy9BZW4vbTdhR0l4c1E3?=
 =?utf-8?B?VTZRT2kyazZiU05OYldOK2k3anhJbnorWlo3a1hmV05EOWhYQUVwZWh0WWJ1?=
 =?utf-8?B?Q0pYQlpzZWQyNTFXd3NTbWVuek5kcVNMUW8zTWorNVRJN25QQlRZaEswUUI3?=
 =?utf-8?B?ZnJQQkpZZVoxTkpwY1V6Z1lBd2JiRU5WZHZWazVmazJod3hZY1ZkdTZ5REFh?=
 =?utf-8?B?WVl3TGlabmJqc0JURWl2aFdDdnlWTEZ0VTJIM2lFbHRxa0pwc1FJOUNrMS9P?=
 =?utf-8?B?dW5SSTczaWJTTFhYaitXQjFZRmdxU3htbXUxM3Z0ZHBDZGY3Q3NremVIL092?=
 =?utf-8?B?cDJZRUJ0S2VyaGxNMXFYVmZlcUlCL0RVMkNsamJzRHRGNHo0V0NzM005WmZw?=
 =?utf-8?B?eWJWaEpjcVo5eGczWHB0ZUE0dUpLTGdJdTZtTDZWcnl6dDU2UUk4cFRMenZa?=
 =?utf-8?B?RWVwUEQrRW90T1dIWmF4T0MwK1J4bkJZZThxRGpWdjh1VXRycGpXWWlCMXo2?=
 =?utf-8?B?MGRuT3BLSGIwQlc1VkRsQ1FITHFnS1dhV21vcVh5UGdpdDE3cGhGalQ1VkVo?=
 =?utf-8?B?Wm9XOHdwc2lUWk43Sk5LNHFVUEg2dkQ4dFE4U214VFJTT2l6M1ZHWUFiZVNv?=
 =?utf-8?B?Um54U1M4c1Z5NGJibXNTQXNya2VWWERaMEZDMXV5M2duWVNMUS9WOURoTjhn?=
 =?utf-8?B?empSMHBSY01iSjd4UytvS1E4Qm1XQkhJNDBYNDBRZmF6VG1xaHYxc29PSHJ2?=
 =?utf-8?B?QnYvcTVFS3BIamJ2RmV5S1ZkUnlLWFg5L29JOFRuVEJveVFPSUN5ZUtIcU5o?=
 =?utf-8?B?bGkraTZXMnh3dzU1OVZuTFRQS0V5L25IU1RMK1dIMFR2dXRCd3pndz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6613510e-e30c-4dcb-8d58-08deba833096
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 17:29:35.2915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDHBFoSTfj+mxwCw/YCKFO6W0a33PcALtwszNua3pHfQ0jR/BgHLLSjbmfvprPeMmwSjBIqhcqdXP357QDtgLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5283
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-9124-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[mailbox.org,samsung.com,kernel.org,redhat.com,garyguo.net,protonmail.com,google.com,umich.edu];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,garyguo.net:mid,garyguo.net:dkim]
X-Rspamd-Queue-Id: 5E8B75CD623
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon May 25, 2026 at 4:51 PM BST, Maurice Hieronymus wrote:
> On Mon, 2026-05-25 at 16:36 +0200, Michal Wilczynski wrote:
>>=20
>> To move forward, we should fix this by implementing the proper
>> generic
>> 64-bit math helper in the Rust abstractions, rather than narrowing
>> the
>> types here. Are you open to looking into adding the Rust equivalent
>> for
>> mul_u64_u64_div_u64_roundup instead?
>
> I would be definitely down, to help with that.
>
> Before I start working on it, a couple of clarification questions.
>
> Should I implement this as a thin FFI wrapper calling the C-Functions?
> Or do you prefer to have a re-implementation in Rust.
>
> Since mul_u64_u64_div_u64_roundup is a macro: Is it okay if this will
> be a small Rust function or should it be a macro as well?

This should definitely not be a macro. You should only use Rust macros when=
 it
needs to be a macro. This function should just be a method of `u64` added v=
ia
an extension trait, so you could use `u64::mul_div_ceil` to invoke it.

The implementation of `mul_u64_add_u64_div_u64`is non-trivial, and thus you
should defer to the C function to avoid re-implementing the same code. Howe=
ver,
I think it'll be fine to first wrap the `mul_u64_add_u64_div_u64` as
`u64::mul_add_div()` and then have `u64::mul_div_ceil()` be

    #[inline]
    fn mul_div_ceil(self, mul: Self, div: Self) -> Self {
        self.mul_add_div(mul, div - 1, div)
    }

Best,
Gary

