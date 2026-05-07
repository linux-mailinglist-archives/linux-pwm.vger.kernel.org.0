Return-Path: <linux-pwm+bounces-8836-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KL+8Bn6E/GmOQwAAu9opvQ
	(envelope-from <linux-pwm+bounces-8836-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 14:24:30 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B134E8270
	for <lists+linux-pwm@lfdr.de>; Thu, 07 May 2026 14:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FE553011BD0
	for <lists+linux-pwm@lfdr.de>; Thu,  7 May 2026 12:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ADEB3C6A5F;
	Thu,  7 May 2026 12:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="i6yc4tkN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022106.outbound.protection.outlook.com [52.101.96.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB1E3B7B93;
	Thu,  7 May 2026 12:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778156656; cv=fail; b=si/9SNBeqJ/lz+N96Ri6xdRfFuoiV90cAdjzlEz2ClZytfsaTHPrjbIt/A8QnTkfsZ1ewYYd5ZI+oQT3YmbDnlIuBORZwzpQppFUxHuQjXKv9mKZ2HLeHQlPTj6dZnOC+leqqFaY8Cvu0dUpc+dsq0E8XC88ZUEPtS4vHym7bkc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778156656; c=relaxed/simple;
	bh=IX2hCSFnalo7yeKaWpDIy59Pamcw9RTNzmyXN7tnPZs=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=pfkx+ndaWNY9yeUUrwlW5elJRBuBvFQucDK2SU9t3l78ZVlmz4q7HBWLZX3AnML7b1kVN9mm0MOVNP+KbVQMSfpoEYb7gqxJvgiERNuIVjzvNTLNnyB+X1Scvd3YFA0ZkP4K8f5nCEUtA/of5lrkkhCn9UrY4LAhp8HB6B2rloA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=i6yc4tkN; arc=fail smtp.client-ip=52.101.96.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZnY6E5NsSOjL1tV8yCL0n2hKbHDKo25lqzIMc4HjoAT/n/rPBu4hu2Blt82etihKtybBTTgiJoE/F+F5jw8iQboage33ZaRr/mbwhQ4YuL747m68+NKdjyPpbie+oB9wH3RTNPZSHMQPcYNf97KkOhbplU7oi9rb/ULPUrNTq26DqeS0vICvgvcz/YEomRHa97sYUfOHme6EgwJJX4hxxzldQscAxUm75Rj2V76/bdToVBBmyrqh9ORPnAww7Sj/Hm1fCMRGBhNJjE/YFhXD4zU4/VCMVAXmTDQoHtigAFqRSK9tX90Dr9sN7X5Ffbsiz11nCNunieFuinAbx3QhZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=saH0XsYH+p9Utp92n8Wo7SnfH0odMFlLMpwzNwnhcRg=;
 b=VrfHS17Vg2tAbAMfDfiZ5jD+VZGY/0FAdwx4SRuJc4oT8bz1JZDPsGqNydZ5/1sN1xfryhfGViSTw2+BR76YQeCnGu9Fg5hEPj2OdqLrlg+ZMvYirHP1m+uj3Wgalhbh2oHIasT9OCkidIbCbmZKSZ5cNl8CRcRsyLLGvsYUdpRZwIC8j+D8HLBzF35OIksGjfJYvvgW/nt09ueLKJZlBzQr3tTem8qMckQjdZZ9fAEqGZvDdbfPa7UVIOv3aNo6zxcTB+bVBP8MVGoYev8zWfVc3G6Rs+QPQ+jwtkOBY8/xbuZdfbuMAicRZdYzeuUcMzKtr49nxny2hwTRE9joxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=saH0XsYH+p9Utp92n8Wo7SnfH0odMFlLMpwzNwnhcRg=;
 b=i6yc4tkNykDsYk1gzPcf0BNP9Ed0CnzXQ0VC4/Elrlg7FEGFmUOH76WaigFMRrZ0/zlDcJTOkXWOGVP6wOCJmpkEpsckd26lyDYk3EG1SZKBEPGybHeh5AU70zV8kzEHr5tChqY2qOYHkNllL62sRPI+QkiYb6xvYoVFieH21hU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB5191.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:241::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 12:24:09 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9891.016; Thu, 7 May 2026
 12:24:09 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 May 2026 13:24:08 +0100
Message-Id: <DICFXB4BLACF.3GTAQPRYURQCB@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH v2 04/25] rust: driver: make Adapter trait
 lifetime-parameterized
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
 <daniel.almeida@collabora.com>
X-Mailer: aerc 0.21.0
References: <20260506215113.851360-1-dakr@kernel.org>
 <20260506215113.851360-5-dakr@kernel.org>
In-Reply-To: <20260506215113.851360-5-dakr@kernel.org>
X-ClientProxiedBy: LO2P265CA0259.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::31) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB5191:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aa2801c-a4f6-4139-9617-08deac3389ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016|921020|56012099003|22082099003|18002099003|3023799003;
X-Microsoft-Antispam-Message-Info:
	DihueJANQeew+ghSe7kD7PRovLE5M/hxH4v2YpQstRceTL4G52aQY7v8rfm/BWmJ//ejQ2jDGFODO2z+XKpj3cunm+tgl1x1hE1vbMXohDqxtuOm05c7EYCRCHtpMtsEqoPV0dfTUQzyrMcsT5PXB8gkGtweTaycjqis9QKoGUVtKNn/ZTbh8woh0rwFKDERqjCudhrqgyiZBX5N23ADAGjJ9kV0Yeng1TRvW6S+Vmj2hhs/dLAE6halXNXhCB1/nRlkcHCl/mPDE2g3etQqhe61S24sEU2b8idLrbm15Q/TLyiHwJnOH9AW6KOc0wr8xA724m8SDSCeRWHGc9KtOy3u0hA/G5VO7wkq4fGt/mHpslI/tWFiBTe1JP0zrTibzkXKOldkJX9uQEaq0rJOv4zwK/V4lD4ZaiFk58wi8qYVTi8GhiZNCDFsyI9YokK+zyFB8N+ODIE52K6N/Jw3f+DCYeCOUf1AFEr5wSs9DSQMhru3zXwEAOKrBVCX8McyOMjAKcIyu8ZtsheVYRhuh/VJnIVkz3GwkRK2XWsufFtvM4N2Rwf4ipQ1W4+UtLMyiaaasqufteGIDFlktDkznzbmgYrQASAvRULM3LW/9+kLz/K1/6SGxjZ+X5AavraEqR9bei9KGBS0YqoHblddcM2nezvGN86x1i3Tm8VN5TYDR7wDnaZqgGdyJHK4bf378Pzb1/o3+N5sk+nJwtoPFlrKcVqfOQoK1GNjstkBLXI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(921020)(56012099003)(22082099003)(18002099003)(3023799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TjREZkpUTGZUUlNWdmp4WVZ0TS9oeFJNd1h4MGpHUmtVWnRNRzBDNTFLblVI?=
 =?utf-8?B?SzlwNFJIUkg0TWNabHlnbUpiRGRZb2RvZE5oc1d4cTNqbjJiQjU4S2xmTGlM?=
 =?utf-8?B?QjA4Q1FneSt0bXo5RUtKYlpDRDFvYUVvV3piaXBxbkIvSEZ0VVVhUVFTVDh5?=
 =?utf-8?B?OCtkdlc2NjQ1V2lINlpMR3NLMDVoVEFCWXpIWnhuS1FHSldyOFJ2SnY0cGNP?=
 =?utf-8?B?RVl5b3ptNU9qS0ZZZFlId0hhbHp2c0dwcHROa1o0SHRNUGhSQ3dOSjMwRUNF?=
 =?utf-8?B?d2RvMzBZaVVLTWRCZUFxUlhqRnI1ZkEvYzVRMkM0U05MSm9wN1c2OVdiQ0RZ?=
 =?utf-8?B?VU13Y01nU2hOTEoyalhxaDA0bTlBR1ByTXZOQmsvQ0t0alVRUkpORmNwS3JS?=
 =?utf-8?B?bE9qQ3ROb1hveGQrRVBaakdYcGY1cHlqN3cyRGpCVGxNZkRzZStZeVJQYnVP?=
 =?utf-8?B?U2FrTGx2c0ZsQU9vVE5oeDZwR2JmcEM2QmZBVmR6cDNVdnNWb2FrRVo1ZGhH?=
 =?utf-8?B?Znp3STAxYlBVTWxFMy9FaGtxMXlTeVg1NEV5OVhKWDhKaWxSeW51THJJWnVo?=
 =?utf-8?B?R29DTHFERkpIdVNJdTZ0V0FESjVybk50RnQzSFYvZ2ZUQmNDNGJiYlpMSDlD?=
 =?utf-8?B?OUZVam5ZS1RGRHNNNGVKR1BEL1lqRTFTQzlwQkNGUUJNd09uQ0FkdUlzS2k4?=
 =?utf-8?B?bHdqTzZycVhFNjFyMStNK3NLRGNXZUozUm1vVmx4WkdSdlB1ZUthVXB3ZXVJ?=
 =?utf-8?B?WEp4eFl5UDhpd0VmTXhaZUcySitYaHRacUdpRUJWOWJwdzdoMEpadElMYkRR?=
 =?utf-8?B?ank5cXFOcWhlNE04d1loVUVudWhwby8xNVEwWUNMOGhjN0t0L0dEV2w0UEYw?=
 =?utf-8?B?NFlFb28zMjlnNXJZb2hpS1NUSThPZCthTXgrMHgzTC82M2tmc0RGWDNHcHVz?=
 =?utf-8?B?dzdUUzJ6TmtsR2hvb2hub2hibHUrTFhxRDMyRmNNY2F6azJRQ1BOTnhjaWVO?=
 =?utf-8?B?OXRhQVhSMVBkQWdRa0o4eGR6NGh3bmRiemhrc0ZSL3NhSXhaWjZoaXZpS3Iz?=
 =?utf-8?B?d0luZFV2aWJTTUJjKzN0ZlVFWGlISkpFT083TVVhWTJJcjNlM3h4eUVrL2Vk?=
 =?utf-8?B?dGtieFRHQS9ybDU5cHFIbTN5aG5OS2JWRkJNQWVUM2pkd3Q1UnZRZ2F1R2sw?=
 =?utf-8?B?QWxiSEtBbmp2SDNqa1JNdGpMSkNCM1VHNXpER1Bnb0pzQVdDa2pRZi9VYURo?=
 =?utf-8?B?bElwc3Y4NmVYcU9TTmgrb0FwVVpFd0NhWUFZeGZoVkg1K2lJWDZtUnJaLzdl?=
 =?utf-8?B?VDczMGNDVW16eGZQcG9JRisxbStqZHVMMzRhMXlvYVVoSlNoRTIvemZqcUFT?=
 =?utf-8?B?bWdndjhrMjZEeVB1c2tMak1PVjJtWm1yUGtobFYzdkRKV1B5TTJFQUh3aW9J?=
 =?utf-8?B?Q0RsSmhtRkt6cks3Uzk5QldPYkt6Z0xwZE5sRUxsVGNsS2dBM2V6bmdlNE92?=
 =?utf-8?B?Q3RhdURCSFZKZ3A4SFRUT1NKM0VOcVBFNVhmSDh6ZzNBRHpDaFRqT3MxVHcx?=
 =?utf-8?B?M0U0dE1VdTUrL3llNEk5bDIxK3BlamdVUEFLTjhuUTIzM095alk5TUwzeGVn?=
 =?utf-8?B?eVhoWUJ1U2g4Rk8zbmQxakhVM0FGM3ZMajlta3dubU15TURnMkpwM3JGcEpN?=
 =?utf-8?B?UnNLODlkUmdUQk52RDFUNjgxWmhva3JmWmh3WXJMd3A1WTNybHhqRUlndTVU?=
 =?utf-8?B?dlUxNTg2ZGRHSFVnWHZ0R05OZ3M3TjYzSDV4VVVPb1U4V3FJVHZ0bGlaQWVj?=
 =?utf-8?B?d0FRWjg5c3lRSW12WFhQTk5hUXdvbEdpSmNWS0JMVHlxS3NMQmg4SExyTGp5?=
 =?utf-8?B?Y1dEenVPQlNkWVVsS1FDRkIrRHhCNnJFWXR1TVQ5R2sxdzhxbWZ1eGt1dXp3?=
 =?utf-8?B?Vzh0WjBteTc2YWpCQkhzVnMrOHovdWlTQlVKRExUTy9PZDNsNDBuY2VqLzdE?=
 =?utf-8?B?Y3JwZ0dadDl6aUNUR1M0NXFuUEtNcERjUTR2YVVCSXIwK056em5mbjFPODhm?=
 =?utf-8?B?U3h5Y0RHTndibXNIblNBMU9EQ1ZKdnB4bUg1djJ3NEZNdTFBWmUzS05KTUla?=
 =?utf-8?B?cG1DS3AwczVNWkptSllUYlI3UEwyUzMvTWxyaXJvejlCUVpCdEZNTkUza2Vh?=
 =?utf-8?B?eWNYbnNteXhIYUd0TFhUcHQ4K2hsQmcxS05iRHlwK2JaQ2ZkZ2haOXVQK3VK?=
 =?utf-8?B?dFFCS0l6ZGdGWVMzZHdmYnVqU0hwZ3ZRU0RHeDJxNHVBK1N1NlVZVktXemJO?=
 =?utf-8?B?L1dzNWlhYUVuTVJsQmJIRjZva2x6ZW1kT3Nkb3E3QzlPbXFFUzVaZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa2801c-a4f6-4139-9617-08deac3389ce
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 12:24:08.9744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nn8iNDywF/ZfqdeIPZ8hN9NqQuZZhV8H/SDvi3+kd2cTldv++EVYXOm79X6KkmrUW8LvGqxAa8f63s8nhQjFSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB5191
X-Rspamd-Queue-Id: A2B134E8270
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8836-lists,linux-pwm=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,nvidia.com,google.com,intel.com,linaro.org,samsung.com,gmail.com,arm.com,posteo.de,garyguo.net,protonmail.com,umich.edu,linux.dev,collabora.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	DKIM_TRACE(0.00)[garyguo.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-pwm];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Wed May 6, 2026 at 10:50 PM BST, Danilo Krummrich wrote:
> Parameterize the Adapter trait with a lifetime, changing the id_info(),
> of_id_info() and acpi_id_info() methods to take &'bound Device<Bound> and
> return &'bound Self::IdInfo instead of &'static.
>
> This is needed for the ForLt conversion of bus driver traits. Once
> Driver becomes lifetime-parameterized, its IdInfo associated type may
> depend on the lifetime parameter.

How? The `IdInfo` is part of the ID table which is static.

I feel that this is really just adding lifetime for the sake of adding it.
Nothing in `Adapter` is really tied to device lifetime.

> With Adapter<'bound>, the impl can set
> IdInfo =3D <F::Of<'bound> as Driver<'bound>>::IdInfo and the lifetime flo=
ws

Well, I do get that you're trying to avoid writing `Driver<'static>`. This =
is
needed because conceptually, a `Driver` trait have a lifetime-dependent par=
t and
a lifetime independent part.

`IdInfo` and `ID_TABLE` are the lifetime-independent part, and `probe` and
`unbind` are lifetime dependent part. We really only have this issue becaus=
e we
use `Self` instead of an associated data for driver's data.

The `Driver` could be more cleanly designed if expressed like this:

    trait Driver {
        type IdInfo;
        const ID_TABLE: IdTable<Self::IdInfo>;

        type Data<'bound>;

        fn probe<'bound>(
            dev: &'bound Device<device::Core>,
            id_info: &'bound Self::IdInfo,
        ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound;

        ...
    }

Then there's no `Driver<'static>` at all.

But even if we don't go with that design, I'd prefer using `Driver<'static>=
` to
giving lifetime parameters to types that shouldn't have one.

> through naturally, avoiding the need for transmute.

I applied the following diff and it doesn't require
additional transmute?

diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
index 7c5148772697..4c5bc31fd71d 100644
--- a/rust/kernel/driver.rs
+++ b/rust/kernel/driver.rs
@@ -316,7 +316,7 @@ unsafe fn acpi_of_match_device(
 /// of a device and a driver.
 ///
 /// It provides bus independent functions for device / driver interactions=
.
-pub trait Adapter<'bound> {
+pub trait Adapter {
     /// The type holding driver private data about each device id supporte=
d by the driver.
     type IdInfo: 'static;
=20
@@ -326,7 +326,7 @@ pub trait Adapter<'bound> {
     /// Returns the driver's private data from the matching entry in the [=
`acpi::IdTable`], if any.
     ///
     /// If this returns `None`, it means there is no match with an entry i=
n the [`acpi::IdTable`].
-    fn acpi_id_info(dev: &'bound Device<Bound>) -> Option<&'bound Self::Id=
Info> {
+    fn acpi_id_info(dev: &Device<Bound>) -> Option<&'static Self::IdInfo> =
{
         #[cfg(not(CONFIG_ACPI))]
         {
             let _ =3D dev;
@@ -360,7 +360,7 @@ fn acpi_id_info(dev: &'bound Device<Bound>) -> Option<&=
'bound Self::IdInfo> {
     /// Returns the driver's private data from the matching entry in the [=
`of::IdTable`], if any.
     ///
     /// If this returns `None`, it means there is no match with an entry i=
n the [`of::IdTable`].
-    fn of_id_info(dev: &'bound Device<Bound>) -> Option<&'bound Self::IdIn=
fo> {
+    fn of_id_info(dev: &Device<Bound>) -> Option<&'static Self::IdInfo> {
         let table =3D Self::of_id_table()?;
=20
         #[cfg(not(any(CONFIG_OF, CONFIG_ACPI)))]
@@ -424,7 +424,7 @@ fn of_id_info(dev: &'bound Device<Bound>) -> Option<&'b=
ound Self::IdInfo> {
     ///
     /// If this returns `None`, it means that there is no match in any of =
the ID tables directly
     /// associated with a [`device::Device`].
-    fn id_info(dev: &'bound Device<Bound>) -> Option<&'bound Self::IdInfo>=
 {
+    fn id_info(dev: &Device<Bound>) -> Option<&'static Self::IdInfo> {
         let id =3D Self::acpi_id_info(dev);
         if id.is_some() {
             return id;
diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index 5a601cba7dc0..739b97c9917d 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -183,7 +183,7 @@ extern "C" fn probe_callback(idev: *mut bindings::i2c_c=
lient) -> kernel::ffi::c_
=20
         from_result(|| {
             let info =3D Self::i2c_id_info(idev)
-                .or_else(|| <Self as driver::Adapter<'_>>::id_info(idev.as=
_ref()));
+                .or_else(|| <Self as driver::Adapter>::id_info(idev.as_ref=
()));
             let data =3D <F::Of<'_> as Driver<'_>>::probe(idev, info);
=20
             idev.as_ref().set_drvdata::<F>(data)?;
@@ -243,19 +243,19 @@ fn i2c_id_info<'bound>(
     }
 }
=20
-impl<'bound, F> driver::Adapter<'bound> for Adapter<F>
+impl<F> driver::Adapter for Adapter<F>
 where
     F: ForLt + 'static,
-    F::Of<'bound>: Driver<'bound>,
+    for<'bound> F::Of<'bound>: Driver<'bound>,
 {
-    type IdInfo =3D <F::Of<'bound> as Driver<'bound>>::IdInfo;
+    type IdInfo =3D <F::Of<'static> as Driver<'static>>::IdInfo;
=20
     fn of_id_table() -> Option<of::IdTable<Self::IdInfo>> {
-        <F::Of<'bound> as Driver<'bound>>::OF_ID_TABLE
+        <F::Of<'static> as Driver<'static>>::OF_ID_TABLE
     }
=20
     fn acpi_id_table() -> Option<acpi::IdTable<Self::IdInfo>> {
-        <F::Of<'bound> as Driver<'bound>>::ACPI_ID_TABLE
+        <F::Of<'static> as Driver<'static>>::ACPI_ID_TABLE
     }
 }
=20
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index f59f22283c53..f4df2e474ca0 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -120,7 +120,7 @@ extern "C" fn probe_callback(pdev: *mut bindings::platf=
orm_device) -> kernel::ff
         let pdev =3D unsafe { &*pdev.cast::<Device<device::CoreInternal>>(=
) };
=20
         from_result(|| {
-            let info =3D <Self as driver::Adapter<'_>>::id_info(pdev.as_re=
f());
+            let info =3D <Self as driver::Adapter>::id_info(pdev.as_ref())=
;
             let data =3D <F::Of<'_> as Driver<'_>>::probe(pdev, info);
=20
             pdev.as_ref().set_drvdata::<F>(data)?;
@@ -143,19 +143,19 @@ extern "C" fn remove_callback(pdev: *mut bindings::pl=
atform_device) {
     }
 }
=20
-impl<'bound, F> driver::Adapter<'bound> for Adapter<F>
+impl<F> driver::Adapter for Adapter<F>
 where
     F: ForLt + 'static,
     for<'b> F::Of<'b>: Driver<'b>,
 {
-    type IdInfo =3D <F::Of<'bound> as Driver<'bound>>::IdInfo;
+    type IdInfo =3D <F::Of<'static> as Driver<'static>>::IdInfo;
=20
     fn of_id_table() -> Option<of::IdTable<Self::IdInfo>> {
-        <F::Of<'bound> as Driver<'bound>>::OF_ID_TABLE
+        <F::Of<'static> as Driver<'static>>::OF_ID_TABLE
     }
=20
     fn acpi_id_table() -> Option<acpi::IdTable<Self::IdInfo>> {
-        <F::Of<'bound> as Driver<'bound>>::ACPI_ID_TABLE
+        <F::Of<'static> as Driver<'static>>::ACPI_ID_TABLE
     }
 }
=20

