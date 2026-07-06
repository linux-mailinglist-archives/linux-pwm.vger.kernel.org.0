Return-Path: <linux-pwm+bounces-9597-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0EbIDGKtS2qKYQEAu9opvQ
	(envelope-from <linux-pwm+bounces-9597-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 15:28:02 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1421B711441
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Jul 2026 15:28:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=garyguo.net header.s=selector1 header.b=L5YNUPDk;
	dmarc=pass (policy=none) header.from=garyguo.net;
	spf=pass (mail.lfdr.de: domain of "linux-pwm+bounces-9597-lists+linux-pwm=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-pwm+bounces-9597-lists+linux-pwm=lfdr.de@vger.kernel.org";
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D1FA43026149
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Jul 2026 12:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFEA433BA1;
	Mon,  6 Jul 2026 12:44:43 +0000 (UTC)
X-Original-To: linux-pwm@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022076.outbound.protection.outlook.com [52.101.96.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F0042E000;
	Mon,  6 Jul 2026 12:44:39 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783341883; cv=fail; b=icLRI9QzRSbmqTo/jwifyAuPAqMnuOuXQHYMNkK4bsvDUJJL5HZvODO3QLPUKjWqES+P1aM/NlzquX36nUSaUZWw/1mJZ0sqd8X/G82vpg56Asny1cC1kh2QkDUiTzqtaHjmbjxBDl8d5S08yg6dZSaWsVpGh90GjD1pLMi41aM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783341883; c=relaxed/simple;
	bh=AHv1yx05v5U+Muc8v8khhQqOM8AC9xG1jrYfwqEXGgU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=VEl3uU3TAQHYBnnzIRoamZDrTNJvOKMw6i/Cg0ToSXDu9p/9XGaAwQERa1bshAGLb8yuGHYYUP18pXmxIDiexu67QEE3q5XFzLSVYUpFoApjJMSRxowo+yy64jFrEeFzkDDdsTbUBp/syuiQxaDX9F9DupsOMM3UkFdaeX41SP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=L5YNUPDk; arc=fail smtp.client-ip=52.101.96.76
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T78VGp12gZ4CAnVa6u1S58ZZu80K068sRbdiLlSNly36jKI2Vji2Bdg/0eZ1esCOZNdkjY0FU/ZPLBRYKBbCc6kjnVmqJoDyMtVBYPSij4A5Qmguw9NhSnzRELI8bvV7mDPxPdt5YRM9pcmUKYNHqM9mLbZsLhhDvspbmaoThWVLAt2L9oS4f0LbWNvhNVZtBdINPRIgJQpfmz51AECWq7DehZLMI20Yd/BpTHBEtBJOs9WfwONyVMmSG/uY41BOfL8F+W8mBTDKL1p/XO0nt7ogUzH8elrriFY+nUrOXoOeUcPv8PivkVquVT6lasPca9u27zH2+pkjZSAPz8TqpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDXLghTTZp9iaIRb3MPfMGy6vNgdgoz1so/oNSaEe/M=;
 b=AuOAMAeIK/sJT3TcnQR5nL6f8qRYKAKkr8fBmtZCPMB1Fj3tLAkq26FreogvvIWE3SkREEEn9JChzibRtMD88Sw51m+/BbCAxxoEeCUS2Ozn953Uza8G2uO2y8nHiv2C9pJQUUtNM0KkdVhAqRBQqVIIIh+EyprqvMcB6hbkfuFSCDbwhb1bf98vQkGREMrG2iEkASKrH9p/yPPma2HcAM8A4jKTrw58OCkf1BX7pKahZe3t7tkDzopEkBhMUA9fsM94cUj3zBcUDT5a3neTnAZZBoNjElYmflHSGdetIvdaNlSW0E1Pyqlyq7srvUt9tyoc2g1IbrIE7BouzWJiPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDXLghTTZp9iaIRb3MPfMGy6vNgdgoz1so/oNSaEe/M=;
 b=L5YNUPDk+/gs33VIAHsgiJ3eIkxyIRoDjXm4/1ZREd7g51Nyacuwm9ILBWvJpGAxH+6tFXCSoTzJfNgXl4a6XO5xAJI0j+FnQvDEj2BdqwsT4UnDHPkW4Mb2kQA87dh0RePhECDE2MwqaqYGyly4i4uvzT4pLojYteRSo5eFfA8=
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO7P265MB7617.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:40c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 12:44:27 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 12:44:27 +0000
From: Gary Guo <gary@garyguo.net>
Date: Mon, 06 Jul 2026 13:44:20 +0100
Subject: [PATCH v6 07/20] rust: io: implement `Mmio` as view type
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-io_projection-v6-7-72cd5d055d54@garyguo.net>
References: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
In-Reply-To: <20260706-io_projection-v6-0-72cd5d055d54@garyguo.net>
To: Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Robin Murphy <robin.murphy@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783341863; l=16305;
 i=gary@garyguo.net; s=20221204; h=from:subject:message-id;
 bh=AHv1yx05v5U+Muc8v8khhQqOM8AC9xG1jrYfwqEXGgU=;
 b=owMBr0GrputAzHVDVCJ6RWKINs6/KsGM1YK2bsJD613H0L0kT24htQUXLai8Th4ueQu6d1p6S
 Ous0gExpbvGBPBBiwfn9ZT26ldUtf1L9i3V6VEI+kkXeQE97iSW03pn
X-Developer-Key: i=gary@garyguo.net; a=ed25519;
 pk=vB3uIX95SM4eVrIqo1DWNWKDKD2xzB+yLLLr0yOPYMo=
X-ClientProxiedBy: LO4P265CA0177.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::20) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO7P265MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d845267-4976-4121-34da-08dedb5c5118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|10070799003|18002099003|921020|5023799004|6133799003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info:
	f6O1SXNIiitwxqyoxhKw5c2mu612aFm3pCM5lXD1NhUcA/F/j2z23HHZl0napHiyzAC0mcfeJHITfjRAIXFA2jNS9F00ggDD1vixaeKztKa2a2KmiIlydj8gjvsBE3FZWs4+qwOZiwtEGZUib4Mo5Y5+gh3m/yypht3LQzEdxyhNQyHKz3ZPH/4gb6zauxTW5S5JEMUdBlFzIJ+XVVHr0aQAeLVKtjuRhSIcwphv8M2ua3AqejkYYU5lvA+jxIbIKq+n4shLIcKN/oyijGlXdbKmAqrzor9FeUsGqmBLMa/5zb5wzVC1h/nypKKWk2odvU+2fWrsTFB9Vmjb0aZF39Ff2tqjz0vm6y5iws0TWp06YigoTyjGZCi8wozMF+qFX9lri42PrSH+CiaADnydvZFicim/s98OHvVP0zvezcmnJlO9aWPlgbVx4+efzOCVEQZWEDBWfmTBx84xAdKJq+vSwUVfQ7R/MWojjOK77o5fSrBWJu2L2ty3n6EQnl6hlYDagbmyIs37wh20QkOc1fvgsNjcdC0v9yC3AZVsZKzeDsRnh2OypIV/MEGxs3Fwzj5H1IMRetS6ENqiOzLrIvSogyGkLrCSPT5KOJi2ORDZMYy111b+HlaG2MkIryq8pD9OpKVlA4u67QTIZAApSsCC2hsN5BSmGIzVYSt3XauYXekujKZWSt1izIpmymAuL93aka3y38Y2LG39ofqsjg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10070799003)(18002099003)(921020)(5023799004)(6133799003)(56012099006)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wlk2YjlzUS95UkhRWisvZ0pyRU1YMWRwaTh3WTdNd0NHRkh5c3lBcG9kMkhO?=
 =?utf-8?B?Z005MjFER3FzTUNBRHhrT1BhZGE2aDJKRUtOWFlTQjA2c2IxRjBpRGJkY1R1?=
 =?utf-8?B?RmRRSFhjdkhtUFJYWDZJejVCa1JlcmM0M2I1dEpBMkVHSUdLSG5hbTdZdTFI?=
 =?utf-8?B?VDBDNkxldGtFNmNBRHllalVmNFBKbzJDV3VzelB3dllIOXRqM1JCN1VIdTU5?=
 =?utf-8?B?VU15enZMc3dkSjdzeHNIbnF3SjRCUGNkT1Q3MHltNUVlTldVbWpwWmVzL0RS?=
 =?utf-8?B?enlSK3lJUGsrZUJ1M3RSVVZSdi9ZY281eFJ1cXZBWmF5RlBwK0JZQlMxSUYv?=
 =?utf-8?B?YURrV1E4cGVNZnRNOEM1c3grSG5xb1FaRElZZDBZb2FRUExBRzRLVjhwelhp?=
 =?utf-8?B?UDBheGlWem9Xek9NMlBEU1dldW13RFJQZzZkN0lhT2IreU9tQ0FvN28zTkox?=
 =?utf-8?B?NmdIU0FQY2pQbDBLWkR2VEJXT3oybzB5bUp3Yk1kaDBnTGY2TkhuaW5XUGhQ?=
 =?utf-8?B?LzdteXZLUXh5VzVkVzcvSVE0a2ZJWVp2Vjl0TGRJTGowL3FYMkRuOVJOQWNr?=
 =?utf-8?B?OE1KeUt6SzNQNjRBc3phY0ViZkxBU0FmMFdQeklOcjdhOHdQT2NhbFJDUnN6?=
 =?utf-8?B?US9GcmFZbkdmNk4xWWtjVDFJVU9UTzJ5TkdwSXZlR3dPelRsd05VQmZPOTlS?=
 =?utf-8?B?NFJBT2d0UWxZQkUraytjRHdaYWhyekg4MjhrNFV6R1JwVTBZb0o3b0R4VDlT?=
 =?utf-8?B?aUUyWDhXS2VwNVNqemlKTmQyR2lzK2FpMFlNQldWcUlFdmw1ZFpXeFVJdzBQ?=
 =?utf-8?B?UzgwNkU2NXZoV3ZWWFloMngvUE5GTTF6RkRBamNGNTFRbWhJM25OdXVQNm0x?=
 =?utf-8?B?UjVnbHhuYXpNOFZyOWhoSk1SMmhHdi9IK2pxUFF5K0Q5WlRybVlURkJ6cW5k?=
 =?utf-8?B?OS9DOFJ6VFFoYUdhc2R0anNlK3lnTzh4YjVucDVVc0ZkSGhlZE9iSFlDNkRV?=
 =?utf-8?B?WkZ5Zm1VL3J3MHNLT0FjYUNKYVp5UWl1c25wajNIdko3aW1RYVFlcnlXbUdG?=
 =?utf-8?B?OCtHSkFuaUN3aHVPMjNZbVBpTmwranpRb3NwMmxzK09Xb29RNTlsV3k4RnlO?=
 =?utf-8?B?Zm1rNzJKVFlUbEo0T3V2aVVJbUtkY0huUGVLVlJRU25BUjZRRTZEazhJbU9B?=
 =?utf-8?B?S2ZHeURhSlc3UkMzL3V3YithRDVIWUExcDlGTzVtNGlUUWtaQ3RKWW85b1l1?=
 =?utf-8?B?Z2hSN0wrMm9LNjNsT2pwaGdlaTVOUy9BYWl5NzRaOTcrZ2dUVHVuS2xseFNs?=
 =?utf-8?B?Z1A4TlMvSjRRNmthd2x5ejlhbEZuejhHSk1RWlVRRFY5Zi8xdDZ1cHloR2Mr?=
 =?utf-8?B?RlRrTWpIREFROVVPVzFoeEhMaXk0SCtScmNiZmp4UXUvU21PSUlZb1lTdlN6?=
 =?utf-8?B?d1JXbXF5eEJaeTJwWFZWbnd3NGRtTGgxaFh2ZnhQSG4xbHU2aTRCeVE3cW5j?=
 =?utf-8?B?VmludHVGZDBrdkJadDhPV3JNQnNNZmJKS0J3MDczemExTVBUNTIrT2wzbnVU?=
 =?utf-8?B?WWcyU1NidkdhY3hjOU5FQnVmNWJOaUZ0amtnK3M3cVpyNnNwN1IzT1lINUd0?=
 =?utf-8?B?c3VQaUYySllHODhjbVcvMXRqenB0azVJSjErR2dIcUhwSkl0UEo4d1M3dnI1?=
 =?utf-8?B?b3oyQ3U2WlhLcWJjeWVGdW5DNklCb3JielFhKzdkenNuYzA2SnByTE9WWVgr?=
 =?utf-8?B?SktzT0lzMm9Kdzl5VHVkbnRpcll0RXEzWFcxQUR2OEUrdHJlUXBGdXpnRVNw?=
 =?utf-8?B?RDBZVG1Ud3pyTVU3RGFqeW9xRGQxcHEzWEJ0K3RLNC8rdzBjWkdsMjlzUk0v?=
 =?utf-8?B?QnFoWmtsNlIxYzJlWnI4R00xNnZUQk8vMG5aT1BWTWl0R25BQ0JOT0hLRkt4?=
 =?utf-8?B?aURaS3FsajhCNDlpQ0xTWkJUVGYvL3F3b2p1QURnQmtGb2IyVTRER0tieDdY?=
 =?utf-8?B?NWl1TldCSDBXc2FkQzgyNW43WUNaYUs4eVFKZVppRUZRYUZxcnZqV3dQWjZV?=
 =?utf-8?B?bXBQZ1dobUFuV0dSQ3VsUitmVHlMWWRQL0NoQ1A0NEVDeWxPQXZ5Sm42VUJK?=
 =?utf-8?B?dGtkbVQ2YTlhbjkwT1N2WHlmNTc3RWs1Q056V3dQbitaZGpWTU1YK0lqQnNr?=
 =?utf-8?B?V28zOEFrdGUyeGRFYW1PeUhaU2ZhZzJxRHV5U0JWcjBhOVV6dTZ2YlBNd3Yr?=
 =?utf-8?B?V1RpdThXbk1GemFMOGg5ZnpkRGlSR05lT3RqM1Q2bDlzOFgxZjgxUGJMWGNW?=
 =?utf-8?B?ejdrbTVnZm9QUW1pQWZMZUxFRXE0aVA0MFNJZm9BbU9Ua05aL2lldz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d845267-4976-4121-34da-08dedb5c5118
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:44:27.7900
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YC94UG1wE5hk5FPM2yx67oF9Vpf4lJwViV/YSRLqYblGKBJY32+ls9cfFQ/JkNTCaAYQ4YNyxhO4zzqEF8+IEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB7617
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[garyguo.net,none];
	R_DKIM_ALLOW(-0.20)[garyguo.net:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9597-lists,linux-pwm=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_TO(0.00)[google.com,collabora.com,linuxfoundation.org,kernel.org,garyguo.net,protonmail.com,umich.edu,onurozkan.dev,gmail.com,arm.com,nvidia.com,ffwll.ch,samsung.com];
	FORGED_RECIPIENTS(0.00)[m:aliceryhl@google.com,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:tmgross@umich.edu,m:tamird@kernel.org,m:work@onurozkan.dev,m:bhelgaas@google.com,m:kwilczynski@kernel.org,m:abdiel.janulgue@gmail.com,m:robin.murphy@arm.com,m:acourbot@nvidia.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:m.wilczynski@samsung.com,m:ukleinek@kernel.org,m:dakr@kernel.org,m:driver-core@lists.linux.dev,m:rust-for-linux@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-pci@vger.kernel.org,m:nova-gpu@lists.linux.dev,m:dri-devel@lists.freedesktop.org,m:linux-pwm@vger.kernel.org,m:abdieljanulgue@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[garyguo.net:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gary@garyguo.net,linux-pwm@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,garyguo.net:from_mime,garyguo.net:email,garyguo.net:mid,garyguo.net:dkim,nvidia.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1421B711441

Implement `Mmio` as view type and convert `RelaxedMmio` to view type as
well. I/O implementations of `MmioOwned` are changed to delegate to the
`Mmio` view type.

All existing users of `MmioOwned` in the documentation which do not
actually reflect the owning semantics is converted.

Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Gary Guo <gary@garyguo.net>
---
 rust/kernel/io.rs          | 176 ++++++++++++++++++++++++++++++++++-----------
 rust/kernel/io/poll.rs     |  10 +--
 rust/kernel/io/register.rs |  24 +++----
 3 files changed, 153 insertions(+), 57 deletions(-)

diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
index f93be7f78069..8110b49aa430 100644
--- a/rust/kernel/io.rs
+++ b/rust/kernel/io.rs
@@ -4,6 +4,10 @@
 //!
 //! C header: [`include/asm-generic/io.h`](srctree/include/asm-generic/io.h)
 
+use core::{
+    marker::PhantomData, //
+};
+
 use crate::{
     bindings,
     prelude::*,
@@ -537,10 +541,11 @@ fn write64(self, value: u64, offset: usize)
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     MmioOwned,
+    ///     Mmio,
+    ///     Region,
     /// };
     ///
-    /// fn do_reads(io: &MmioOwned) -> Result {
+    /// fn do_reads(io: Mmio<'_, Region>) -> Result {
     ///     // 32-bit read from address `0x10`.
     ///     let v: u32 = io.try_read(0x10)?;
     ///
@@ -571,10 +576,11 @@ fn try_read<T, L>(self, location: L) -> Result<T>
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     MmioOwned,
+    ///     Mmio,
+    ///     Region,
     /// };
     ///
-    /// fn do_writes(io: &MmioOwned) -> Result {
+    /// fn do_writes(io: Mmio<'_, Region>) -> Result {
     ///     // 32-bit write of value `1` at address `0x10`.
     ///     io.try_write(0x10, 1u32)?;
     ///
@@ -609,7 +615,8 @@ fn try_write<T, L>(self, location: L, value: T) -> Result
     /// use kernel::io::{
     ///     register,
     ///     Io,
-    ///     MmioOwned,
+    ///     Mmio,
+    ///     Region,
     /// };
     ///
     /// register! {
@@ -625,7 +632,7 @@ fn try_write<T, L>(self, location: L, value: T) -> Result
     ///     }
     /// }
     ///
-    /// fn do_write_reg(io: &MmioOwned) -> Result {
+    /// fn do_write_reg(io: Mmio<'_, Region>) -> Result {
     ///
     ///     io.try_write_reg(VERSION::new(1, 0))
     /// }
@@ -654,10 +661,11 @@ fn try_write_reg<T, L, V>(self, value: V) -> Result
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     MmioOwned,
+    ///     Mmio,
+    ///     Region,
     /// };
     ///
-    /// fn do_update(io: &MmioOwned<0x1000>) -> Result {
+    /// fn do_update(io: Mmio<'_, Region<0x1000>>) -> Result {
     ///     io.try_update(0x10, |v: u32| {
     ///         v + 1
     ///     })
@@ -691,10 +699,11 @@ fn try_update<T, L, F>(self, location: L, f: F) -> Result
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     MmioOwned,
+    ///     Mmio,
+    ///     Region,
     /// };
     ///
-    /// fn do_reads(io: &MmioOwned<0x1000>) {
+    /// fn do_reads(io: Mmio<'_, Region<0x1000>>) {
     ///     // 32-bit read from address `0x10`.
     ///     let v: u32 = io.read(0x10);
     ///
@@ -723,10 +732,11 @@ fn read<T, L>(self, location: L) -> T
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     MmioOwned,
+    ///     Mmio,
+    ///     Region,
     /// };
     ///
-    /// fn do_writes(io: &MmioOwned<0x1000>) {
+    /// fn do_writes(io: Mmio<'_, Region<0x1000>>) {
     ///     // 32-bit write of value `1` at address `0x10`.
     ///     io.write(0x10, 1u32);
     ///
@@ -757,7 +767,8 @@ fn write<T, L>(self, location: L, value: T)
     /// use kernel::io::{
     ///     register,
     ///     Io,
-    ///     MmioOwned,
+    ///     Mmio,
+    ///     Region,
     /// };
     ///
     /// register! {
@@ -773,7 +784,7 @@ fn write<T, L>(self, location: L, value: T)
     ///     }
     /// }
     ///
-    /// fn do_write_reg(io: &MmioOwned<0x1000>) {
+    /// fn do_write_reg(io: Mmio<'_, Region<0x1000>>) {
     ///     io.write_reg(VERSION::new(1, 0));
     /// }
     /// ```
@@ -801,10 +812,11 @@ fn write_reg<T, L, V>(self, value: V)
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     MmioOwned,
+    ///     Mmio,
+    ///     Region,
     /// };
     ///
-    /// fn do_update(io: &MmioOwned<0x1000>) {
+    /// fn do_update(io: Mmio<'_, Region<0x1000>>) {
     ///     io.update(0x10, |v: u32| {
     ///         v + 1
     ///     })
@@ -828,16 +840,72 @@ fn update<T, L, F>(self, location: L, f: F)
     }
 }
 
+/// A view of memory-mapped I/O region.
+///
+/// # Invariant
+///
+/// `ptr` points to a valid and aligned memory-mapped I/O region for the duration lifetime `'a`.
+pub struct Mmio<'a, T: ?Sized> {
+    ptr: *mut T,
+    phantom: PhantomData<&'a ()>,
+}
+
+impl<T: ?Sized> Copy for Mmio<'_, T> {}
+impl<T: ?Sized> Clone for Mmio<'_, T> {
+    #[inline]
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+
+impl<'a, T: ?Sized> Mmio<'a, T> {
+    /// Create a `Mmio`, providing the accessors to the MMIO mapping.
+    ///
+    /// # Safety
+    ///
+    /// `raw` represents a valid and aligned memory-mapped I/O region while `'a` is alive.
+    #[inline]
+    pub unsafe fn from_raw(raw: MmioRaw<T>) -> Self {
+        // INVARIANT: Per safety requirement.
+        Self {
+            ptr: raw.ptr,
+            phantom: PhantomData,
+        }
+    }
+}
+
+// SAFETY: `Mmio<'_, T>` is conceptually `&T` but in I/O memory.
+unsafe impl<T: ?Sized + Sync> Send for Mmio<'_, T> {}
+
+// SAFETY: `Mmio<'_, T>` is conceptually `&T` but in I/O memory.
+unsafe impl<T: ?Sized + Sync> Sync for Mmio<'_, T> {}
+
+impl<T: ?Sized + KnownSize> Io for Mmio<'_, T> {
+    type Target = T;
+
+    #[inline]
+    fn addr(self) -> usize {
+        self.ptr.addr()
+    }
+
+    #[inline]
+    fn maxsize(self) -> usize {
+        KnownSize::size(self.ptr)
+    }
+}
+
 /// Implements [`IoCapable`] on `$mmio` for `$ty` using `$read_fn` and `$write_fn`.
 macro_rules! impl_mmio_io_capable {
     ($mmio:ident, $(#[$attr:meta])* $ty:ty, $read_fn:ident, $write_fn:ident) => {
         $(#[$attr])*
-        impl<const SIZE: usize> IoCapable<$ty> for &$mmio<SIZE> {
+        impl<T: ?Sized> IoCapable<$ty> for $mmio<'_, T> {
+            #[inline]
             unsafe fn io_read(self, address: usize) -> $ty {
                 // SAFETY: By the trait invariant `address` is a valid address for MMIO operations.
                 unsafe { bindings::$read_fn(address as *const c_void) }
             }
 
+            #[inline]
             unsafe fn io_write(self, value: $ty, address: usize) {
                 // SAFETY: By the trait invariant `address` is a valid address for MMIO operations.
                 unsafe { bindings::$write_fn(value, address as *mut c_void) }
@@ -847,17 +915,12 @@ unsafe fn io_write(self, value: $ty, address: usize) {
 }
 
 // MMIO regions support 8, 16, and 32-bit accesses.
-impl_mmio_io_capable!(MmioOwned, u8, readb, writeb);
-impl_mmio_io_capable!(MmioOwned, u16, readw, writew);
-impl_mmio_io_capable!(MmioOwned, u32, readl, writel);
+impl_mmio_io_capable!(Mmio, u8, readb, writeb);
+impl_mmio_io_capable!(Mmio, u16, readw, writew);
+impl_mmio_io_capable!(Mmio, u32, readl, writel);
 // MMIO regions on 64-bit systems also support 64-bit accesses.
-impl_mmio_io_capable!(
-    MmioOwned,
-    #[cfg(CONFIG_64BIT)]
-    u64,
-    readq,
-    writeq
-);
+#[cfg(CONFIG_64BIT)]
+impl_mmio_io_capable!(Mmio, u64, readq, writeq);
 
 impl<'a, const SIZE: usize> Io for &'a MmioOwned<SIZE> {
     type Target = Region<SIZE>;
@@ -875,6 +938,23 @@ fn maxsize(self) -> usize {
     }
 }
 
+impl<'a, const SIZE: usize, T> IoCapable<T> for &'a MmioOwned<SIZE>
+where
+    Mmio<'a, Region<SIZE>>: IoCapable<T>,
+{
+    #[inline]
+    unsafe fn io_read(self, address: usize) -> T {
+        // SAFETY: Per safety requirement.
+        unsafe { self.as_view().io_read(address) }
+    }
+
+    #[inline]
+    unsafe fn io_write(self, value: T, address: usize) {
+        // SAFETY: Per safety requirement.
+        unsafe { self.as_view().io_write(value, address) }
+    }
+}
+
 impl<const SIZE: usize> MmioOwned<SIZE> {
     /// Converts an `MmioRaw` into an `MmioOwned` instance, providing the accessors to the MMIO
     /// mapping.
@@ -887,19 +967,33 @@ pub unsafe fn from_raw(raw: &MmioRaw<Region<SIZE>>) -> &Self {
         // SAFETY: `MmioOwned` is a transparent wrapper around `MmioRaw`.
         unsafe { &*core::ptr::from_ref(raw).cast() }
     }
+
+    /// Return a view that covers the full region.
+    #[inline]
+    pub fn as_view(&self) -> Mmio<'_, Region<SIZE>> {
+        // SAFETY: `Mmio` has same invariant as `MmioOwned`.
+        unsafe { Mmio::from_raw(self.0) }
+    }
 }
 
-/// [`MmioOwned`] wrapper using relaxed accessors.
+/// [`Mmio`] but using relaxed accessors.
 ///
 /// This type provides an implementation of [`Io`] that uses relaxed I/O MMIO operands instead of
 /// the regular ones.
 ///
-/// See [`MmioOwned::relaxed`] for a usage example.
-#[repr(transparent)]
-pub struct RelaxedMmio<const SIZE: usize = 0>(MmioOwned<SIZE>);
+/// See [`Mmio::relaxed`] for a usage example.
+pub struct RelaxedMmio<'a, T: ?Sized>(Mmio<'a, T>);
 
-impl<'a, const SIZE: usize> Io for &'a RelaxedMmio<SIZE> {
-    type Target = Region<SIZE>;
+impl<T: ?Sized> Copy for RelaxedMmio<'_, T> {}
+impl<T: ?Sized> Clone for RelaxedMmio<'_, T> {
+    #[inline]
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+
+impl<T: ?Sized + KnownSize> Io for RelaxedMmio<'_, T> {
+    type Target = T;
 
     #[inline]
     fn addr(self) -> usize {
@@ -912,8 +1006,8 @@ fn maxsize(self) -> usize {
     }
 }
 
-impl<const SIZE: usize> MmioOwned<SIZE> {
-    /// Returns a [`RelaxedMmio`] reference that performs relaxed I/O operations.
+impl<'a, T: ?Sized> Mmio<'a, T> {
+    /// Returns a [`RelaxedMmio`] that performs relaxed I/O operations.
     ///
     /// Relaxed accessors do not provide ordering guarantees with respect to DMA or memory accesses
     /// and can be used when such ordering is not required.
@@ -923,20 +1017,20 @@ impl<const SIZE: usize> MmioOwned<SIZE> {
     /// ```no_run
     /// use kernel::io::{
     ///     Io,
-    ///     MmioOwned,
+    ///     Mmio,
+    ///     Region,
     ///     RelaxedMmio,
     /// };
     ///
-    /// fn do_io(io: &MmioOwned<0x100>) {
+    /// fn do_io(io: Mmio<'_, Region<0x100>>) {
     ///     // The access is performed using `readl_relaxed` instead of `readl`.
     ///     let v = io.relaxed().read32(0x10);
     /// }
     ///
     /// ```
-    pub fn relaxed(&self) -> &RelaxedMmio<SIZE> {
-        // SAFETY: `RelaxedMmio` is `#[repr(transparent)]` over `MmioOwned`, so `MmioOwned<SIZE>`
-        // and `RelaxedMmio<SIZE>` have identical layout.
-        unsafe { core::mem::transmute(self) }
+    #[inline]
+    pub fn relaxed(self) -> RelaxedMmio<'a, T> {
+        RelaxedMmio(self)
     }
 }
 
diff --git a/rust/kernel/io/poll.rs b/rust/kernel/io/poll.rs
index 79828a8006b5..d75f2fcf46f2 100644
--- a/rust/kernel/io/poll.rs
+++ b/rust/kernel/io/poll.rs
@@ -47,14 +47,15 @@
 /// ```no_run
 /// use kernel::io::{
 ///     Io,
-///     MmioOwned,
+///     Mmio,
+///     Region,
 ///     poll::read_poll_timeout, //
 /// };
 /// use kernel::time::Delta;
 ///
 /// const HW_READY: u16 = 0x01;
 ///
-/// fn wait_for_hardware<const SIZE: usize>(io: &MmioOwned<SIZE>) -> Result {
+/// fn wait_for_hardware<const SIZE: usize>(io: Mmio<'_, Region<SIZE>>) -> Result {
 ///     read_poll_timeout(
 ///         // The `op` closure reads the value of a specific status register.
 ///         || io.try_read16(0x1000),
@@ -134,14 +135,15 @@ pub fn read_poll_timeout<Op, Cond, T>(
 /// ```no_run
 /// use kernel::io::{
 ///     Io,
-///     MmioOwned,
+///     Mmio,
+///     Region,
 ///     poll::read_poll_timeout_atomic, //
 /// };
 /// use kernel::time::Delta;
 ///
 /// const HW_READY: u16 = 0x01;
 ///
-/// fn wait_for_hardware<const SIZE: usize>(io: &MmioOwned<SIZE>) -> Result {
+/// fn wait_for_hardware<const SIZE: usize>(io: Mmio<'_, Region<SIZE>>) -> Result {
 ///     read_poll_timeout_atomic(
 ///         // The `op` closure reads the value of a specific status register.
 ///         || io.try_read16(0x1000),
diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
index fd3bf6220f95..6cb07fc92cc3 100644
--- a/rust/kernel/io/register.rs
+++ b/rust/kernel/io/register.rs
@@ -58,7 +58,7 @@
 //!     },
 //!     num::Bounded,
 //! };
-//! # use kernel::io::MmioOwned;
+//! # use kernel::io::{Mmio, Region};
 //! # register! {
 //! #     pub BOOT_0(u32) @ 0x00000100 {
 //! #         15:8 vendor_id;
@@ -66,7 +66,7 @@
 //! #         3:0 minor_revision;
 //! #     }
 //! # }
-//! # fn test(io: &MmioOwned<0x1000>) {
+//! # fn test(io: Mmio<'_, Region<0x1000>>) {
 //! # fn obtain_vendor_id() -> u8 { 0xff }
 //!
 //! // Read from the register's defined offset (0x100).
@@ -446,7 +446,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///         Io,
 ///     },
 /// };
-/// # use kernel::io::MmioOwned;
+/// # use kernel::io::{Mmio, Region};
 ///
 /// register! {
 ///     FIXED_REG(u32) @ 0x100 {
@@ -455,7 +455,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: &MmioOwned<0x1000>) {
+/// # fn test(io: Mmio<'_, Region<0x1000>>) {
 /// let val = io.read(FIXED_REG);
 ///
 /// // Write from an already-existing value.
@@ -559,7 +559,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///         Io,
 ///     },
 /// };
-/// # use kernel::io::MmioOwned;
+/// # use kernel::io::{Mmio, Region};
 ///
 /// // Type used to identify the base.
 /// pub struct CpuCtlBase;
@@ -584,7 +584,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: MmioOwned<0x1000>) {
+/// # fn test(io: Mmio<'_, Region<0x1000>>) {
 /// // Read the status of `Cpu0`.
 /// let cpu0_started = io.read(CPU_CTL::of::<Cpu0>());
 ///
@@ -601,7 +601,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test2(io: MmioOwned<0x1000>) {
+/// # fn test2(io: Mmio<'_, Region<0x1000>>) {
 /// // Start the aliased `CPU0`, leaving its other fields untouched.
 /// io.update(CPU_CTL_ALIAS::of::<Cpu0>(), |r| r.with_alias_start(true));
 /// # }
@@ -638,7 +638,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///         Io,
 ///     },
 /// };
-/// # use kernel::io::MmioOwned;
+/// # use kernel::io::{Mmio, Region};
 /// # fn get_scratch_idx() -> usize {
 /// #   0x15
 /// # }
@@ -651,7 +651,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: &MmioOwned<0x1000>)
+/// # fn test(io: Mmio<'_, Region<0x1000>>)
 /// #     -> Result<(), Error>{
 /// // Read scratch register 0, i.e. I/O address `0x80`.
 /// let scratch_0 = io.read(SCRATCH::at(0)).value();
@@ -724,7 +724,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///         Io,
 ///     },
 /// };
-/// # use kernel::io::MmioOwned;
+/// # use kernel::io::{Mmio, Region};
 /// # fn get_scratch_idx() -> usize {
 /// #   0x15
 /// # }
@@ -752,7 +752,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test(io: &MmioOwned<0x1000>) -> Result<(), Error> {
+/// # fn test(io: Mmio<'_, Region<0x1000>>) -> Result<(), Error> {
 /// // Read scratch register 0 of CPU0.
 /// let scratch = io.read(CPU_SCRATCH::of::<Cpu0>().at(0));
 ///
@@ -794,7 +794,7 @@ fn into_io_op(self) -> (FixedRegisterLoc<T>, T) {
 ///     }
 /// }
 ///
-/// # fn test2(io: &MmioOwned<0x1000>) -> Result<(), Error> {
+/// # fn test2(io: Mmio<'_, Region<0x1000>>) -> Result<(), Error> {
 /// let cpu0_status = io.read(CPU_FIRMWARE_STATUS::of::<Cpu0>()).status();
 /// # Ok(())
 /// # }

-- 
2.54.0


