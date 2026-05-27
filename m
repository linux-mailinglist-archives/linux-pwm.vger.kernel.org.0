Return-Path: <linux-pwm+bounces-9176-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CI7RGpTzFmo6ygcAu9opvQ
	(envelope-from <linux-pwm+bounces-9176-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 15:37:24 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CF35E514D
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 15:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CE7630D693D
	for <lists+linux-pwm@lfdr.de>; Wed, 27 May 2026 13:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28EA540FD86;
	Wed, 27 May 2026 13:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="XIF04ARi"
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022113.outbound.protection.outlook.com [52.101.96.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961A5405C49;
	Wed, 27 May 2026 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779888672; cv=fail; b=c7zKC+BaAVO+5fw0IM6OQVpWb7i4EIZzEdOftcHyLqIG3GEcG67s42A954pLr6PdHdDMtRSS1OoY6bltcBgyMd/r6GQUn4PAGM3fPGP/LAkzBpRQR1ovg8iksjXsvDfXaHKe5Uz4gKXo+/+bPB002yhjiXrLG8fZF/E1rfwTp1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779888672; c=relaxed/simple;
	bh=odaieCEA4qLvz1zwRfCqkjsUXPvvBgGa3Sq6LhzSptw=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=RkHZInXtWFZOj/jRHD4G5yNVWu+ZLvWUMPbChJtuf+KoWaFPjsefpFV7iLxlV2GTJQGd44ApMQyeAsdzYt5W4PdLucQNJiSUD8oM5rgnsAvuj72h9q4HZzLYFsM1BlTEipzNNxtElNWD175ziK4z8v93F0wTBoD953yDdo1qTOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=XIF04ARi; arc=fail smtp.client-ip=52.101.96.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/AC+rBrsqC2lK4eHsgg+//J8zuH0YkTUvAqwXOtmBqEJJ0nn7Pb3wnMyY+aqkuXbHGMCmHmqd9l4hTk2sWfvYqhiqbW4vnrg9fkGsrVHbQKI+2vKkmGLNBJmh1pNzkIJI9JQxiki124xIcDMBMNH+sTGvcweodvG1HpoQzqdK82RDgnvAJC7q3+WCad7Baxz8WX7RsWXvd2etb9gbhCBwGlnC85Uo/3v7j0szjodUK/HhHfvDGK7j21RhV/wi1T8jz78rAWPgBxQFsTr2uHhPscs7keliACKVVuiki52fawXWpDc6askKGZD4xj73wZFj0kypu/XbYDkMaZW2xz0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JAShauWEww4U65MExQoYK5BhR72dnVdCBsxAwiLRBhY=;
 b=dp2qCIrPouDraN4SZq42rmC3a7Lz5aqNzHIygn249mMAGMSFDSJK0URi+nbb3F3N7rvP5ZaZAnO/oP118voHmaaR6mtskb5QZT4kfa6WpbOH1cyG/SSatBa07+9SgtxSGd/yYxC0DKj1lCYmCq0Bn8aV+tKmRviYTlZBXO3Gc5NSsTxHIMlt8hXc1OHtHr/CelDbAaYmsZUgLwO1cVg330LjL0GXxdBiz/0YBHRZk7ktCSOWCNPKKkS3tVu8s7DD+Ps0u8xRwz+Cp2Yo6j0SUPxpIRK0erbfEGgFmBVkwkpc+Bl+nJ62ZCeU5jAqvRVDtS3xnWlqYKfJE3lpUrXRmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAShauWEww4U65MExQoYK5BhR72dnVdCBsxAwiLRBhY=;
 b=XIF04ARicp1NoyIPmuTTIT1Y5cMUDEZsua4850xLGFP9N7A+JrO4D4xcAkuI/Qt58lgraS+uIMnxHerbeFh72EFHJVJo76RjGfCWjTio/xWu9NBzWeDR3nGnM/IToytDyQR7hZp35kI3OKnC2CNxmbIp7XjNID0og4wrvl77/5I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB3578.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1b7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 13:31:08 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 13:31:08 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 May 2026 14:31:07 +0100
Message-Id: <DITHVHQXCG0O.A4KY7WGBL8TR@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-pm@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>, "Eliot
 Courtney" <ecourtney@nvidia.com>
Subject: Re: [PATCH v5 19/24] rust: io: make IoMem and ExclusiveIoMem
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
 <daniel.almeida@collabora.com>, <pcolberg@redhat.com>
X-Mailer: aerc 0.21.0
References: <20260525202921.124698-1-dakr@kernel.org>
 <20260525202921.124698-20-dakr@kernel.org>
In-Reply-To: <20260525202921.124698-20-dakr@kernel.org>
X-ClientProxiedBy: LO4P265CA0079.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bd::12) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB3578:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b65dffe-38b9-4d71-678e-08debbf435af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003|921020|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EtDBLNwA3qweCdWNVPoznhtRpxzqHCHpos6CEqLf3WfeCYaYCuLpAfyhbs99zQvuPy300V9S8qofIcxR70RyNfMbd90epfVzSwzmNOVsR+b0t0F7xS5KHUV+aUYpnyNupVl7/GWt5Mpesk2BnMNGymzLkt8038aMzs8kb+c7mmKyar8gAFbkMAKBqJ9mK5q8XzwSNPFkdmdqO42xpe8JLYwVe70QFELygMzhaaXaMXsK984WZXgz0cZ8i4+67dsu5ht4MKEsIVxNMHzXG4d8pnveXGzGz8XaqF9GMZzxv+79F0K0hVpIQtXRZDT9TkYHmQBqvG9N/JxaCr/RQWfoYQGg3RAgrcA/TzWcan84il3uux6szU2G6Bk7PMSuojzQ7rJhj1a5983JXEPoo7OPOQRi0ZNpWnqXj3aae2IYV304oFbwuAj0D/RhdCyA2Llq0qRqss6UYNNptvHzFLQdcimOoDX+2YgtvxGjxGChyLTWeaM0hl8nTF4dSy/A5H1vFbCkLd4RHcmjZ6/Ozg88rt/snm013UDafJshKvVmoElpQM13C45jUBrpX9IHIq3KSotW8SKkAScLIh1hIvjjxT8HLpmg9FtUJCFXddDH3U6HyEFH1NDiQU6QkhuofZ5eqRnE3CJgDCCshIpFgy63RGdUyLy2Z9uxxA11WaOXp9xzkfhIgotYYFrIbq1FNuxYMaR7slMtHzdyL6iqsoFn9EZvjOIh1Gb+J0sYZRoqsBA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003)(921020)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RnVPOXNVYXh0dUtaRWJEYkRqMzdzNDNKZGpBd2wxWGs1UjJCYlN2MTBjNCtz?=
 =?utf-8?B?MlQxMUFBOVF4Ujc0UXNCMWVLSkEyVkk0bFZKTnlUK010dHk4T3lFYjJRV1VZ?=
 =?utf-8?B?a1lNVXczZ1ZqYW9jOXJ6dU1zbFBFNW1BVEdjNkc5WVZpQjJOTDFqK3hWNmpE?=
 =?utf-8?B?VWRnMWdIcmxrMzN6WGVxMGlHMGRxMnFVTXRtOXVSSHFtamt3R3UwUkpyUDBJ?=
 =?utf-8?B?QkE4eCtCT203Z2pYSFp1YlVDR3JKelc3NXYwRGx2VmpnQzBsNi9yb0lPRzF1?=
 =?utf-8?B?RFdRMnIrRVVIUUdiMlFPN2Z2L09KYzJkUkpwNWVCRVdWNXRWOTNXLzIvQnQz?=
 =?utf-8?B?cElYVkhtUXhBUUJMZ3U2SFNlQ0hsMHcvdHJCK2pYV09hSGhzUFYzVHJVaVFz?=
 =?utf-8?B?aC9acG1YQ2JXa25UUCt1b1N2YnlFYWtCN3BRUWUrbkduMHBNbFlrT09uS2t5?=
 =?utf-8?B?ZTAvcDE0K3VPcUdBSXJ2S0NtS2dCanIwb0RZenV4S242WDQ1c3dDRnRSYUJE?=
 =?utf-8?B?OGMrZlRlSlVVTnNRaERTcCswVGdSMGp6YmN4eWozMEpjbHJmV1daZ2Nja2xS?=
 =?utf-8?B?LzlKMENxdW9EM0lLM0lEcmZWNHduOUFOazNjV1JzUGc3YVQ1RWVtU2NhVC83?=
 =?utf-8?B?ekZyUXlxempOV01RcGZYRmNNeURKU2txd2x1RGZweGpGblBmOEdqMzdWNFY1?=
 =?utf-8?B?TDE0SStOWSs4TXQ2VnRneEcxcTNLSnFUeEk3eDI3OE5NTWJoV0E2UFdMQXYy?=
 =?utf-8?B?cWp0d2pFb2xUWnUvc255bzNYMUU0Yzk2UWQ0TjNpQkR3UVEyMHhoMm1ZWTAr?=
 =?utf-8?B?aUZJTC8vWldVbFdlZ2trRThnQkVaMjd3dThINE1ZdjZtZG8zUXFZQ2k0MzMr?=
 =?utf-8?B?KzlBNE1HTlpkOXdaT2JhMHBydjFkMXNVaitJbjJJMW1wcEVMTXZIcUd2Zmgx?=
 =?utf-8?B?RERPejFkOEJxczllNGNPdGxkTmxnNDNkY0R0YzRMM0tFc0ZjanNHY3IvbW5w?=
 =?utf-8?B?U25FektrenRhS2szTmFtRkZQQ2ZWbFh4OTFzMktBbWVmZlk1Ni9mNjZabmox?=
 =?utf-8?B?enBhNjdpUm5TMTd4RGVmKzRZMEFLNWJLVFdKMHpmeXlrYWlGMnFZVGZWOHA3?=
 =?utf-8?B?TTE5dWdqS3dRK2tKRDJHSytGUE9OUE9pc0piY3dxOEFobVFUQzhPd3RPV1I4?=
 =?utf-8?B?bzhzcVFlUy9ZMTJCVkZpMFFtMGd6OUFPSU92WDVKdkF5QTArZ0N5YlNsWW91?=
 =?utf-8?B?YTZpNWVJeWtQVXVXZjdpRG8zc283Y3hEKzNRNmluU2ZrRVE5WUtXeTd6QmhW?=
 =?utf-8?B?Mmd1bHhoQlhDRForQ1JtSzRVcldHRDJkYVBKZW9iM1AySngyRHB0RUcvakt6?=
 =?utf-8?B?cVNnR0xMMytzUVh2THdHdys4eWREVTdaaFZxczN3Q2pzY1A5K1FNbjVtNlAz?=
 =?utf-8?B?NXFiRTdxOWwvUmlIRUVsNHRMbkNaSHRiMnE1aEljcGhxMVpoM05zWDVTWnlN?=
 =?utf-8?B?elBxbjQ4bUQyTUdIeFRueTZLd2xvbUJ2cWlnZkxrWnF0ZjRPS3FiNUIrYysx?=
 =?utf-8?B?RGJtSzJMTkZsbzBVUjhNS2R6Rk83N0p0TUlsT01EbTZrbE1Ea01DbTJlMGEz?=
 =?utf-8?B?RUIxRkFvcmZpdWFkTkJQRFJZZndtaU50WkhVNENtUWwrUnErMTdoNXg1QnBE?=
 =?utf-8?B?TDVISUdmUEF1clJiTytKQ0NGWU9HamlvRkJuakJLM3h6blVWZUZzNmo0THZs?=
 =?utf-8?B?VXIvVitOUUwxcGNMb2dCRjRRaHpBYXBhL1cwTHk3cFlmTTJnWm40d3pOUkU5?=
 =?utf-8?B?REJtNUFuRHhhSllnaGVXbFBPc3FsRVZOT1VleHhDdVBYS1o0R0ZXaC9pZFov?=
 =?utf-8?B?TTJGbFJ6U1gvVEQzdFMvL2lEa1B6MllZb3JnbG9YRTdhSDdjUWRIYXZ6MDVL?=
 =?utf-8?B?SUVaNXhZR29TaXphZ1h6NDl6ekxSaGdWQ2l1djVLWS9KVm0rbVhMQUhHWmp0?=
 =?utf-8?B?cHBLNDlZRG1kbVF5T1Fsb1NkZ2RYMFU2N252SVdNenR3dTdjdWRlUWpwcDd0?=
 =?utf-8?B?S05CMGZ4M3V4L0JkRTZyb09MdlAxTGpkMnRkSm5uUCtsbkI2WmQyajgxWmhh?=
 =?utf-8?B?eGdmTFF1S2ZleC9xR3JUeWxhdSsrcGhIcEgwZVlBbDc3SEVCM2NtRk9Gd01Q?=
 =?utf-8?B?ckNaMjMxbDJBMG1PNFF3ejZZTzBsQUg2NnhnVzI3VEM0SlNwZm02bGs3bHlV?=
 =?utf-8?B?UHN1MnZpRmhZeTI4NjNwL0dxYUY2OHRHTXJvUTVuaXdsV3pDUHNKUDJYNmV6?=
 =?utf-8?B?N3dkSDZ6YS9xRTZqZHZmUDlxVGNkK3FrRzd5YlI2eWtCN2JKVHR6QT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b65dffe-38b9-4d71-678e-08debbf435af
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 13:31:08.1029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OJNj+RLiulh/wYz13mK1sl6HFyFfhJ5n3kIV8BYemVhHsCFqUgRlFnsacFGJ0fweA0bjCIntyh69BWNikpXZ6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3578
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9176-lists,linux-pwm=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim,nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D7CF35E514D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon May 25, 2026 at 9:21 PM BST, Danilo Krummrich wrote:
> Add a lifetime parameter to IoMem<'a, SIZE> and ExclusiveIoMem<'a,
> SIZE>, storing a &'a Device<Bound> reference to tie the mapping to the
> device's lifetime.
>=20
> This mirrors the pci::Bar<'a, SIZE> design and enables drivers to hold
> I/O memory mappings directly in their HRT private data, tied to the
> device lifetime.
>=20
> IoRequest::iomap_* methods now return the mapping directly instead of
> wrapping it in Devres. Callers that need device-managed revocation can
> call the new into_devres() method.
>=20
> Acked-by: Uwe Kleine-K=C3=B6nig <ukleinek@kernel.org>
> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  drivers/gpu/drm/tyr/driver.rs |   4 +-
>  drivers/pwm/pwm_th1520.rs     |   4 +-
>  rust/kernel/io/mem.rs         | 103 +++++++++++++++++-----------------
>  3 files changed, 56 insertions(+), 55 deletions(-)


