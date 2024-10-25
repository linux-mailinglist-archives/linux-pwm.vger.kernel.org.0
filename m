Return-Path: <linux-pwm+bounces-3853-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C45B9AFAE9
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 09:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F67280F3E
	for <lists+linux-pwm@lfdr.de>; Fri, 25 Oct 2024 07:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6964418D655;
	Fri, 25 Oct 2024 07:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iris-sensing.com header.i=@iris-sensing.com header.b="Pq6DFW5T"
X-Original-To: linux-pwm@vger.kernel.org
Received: from BEUP281CU002.outbound.protection.outlook.com (mail-germanynorthazon11020089.outbound.protection.outlook.com [52.101.169.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A46518BB9A;
	Fri, 25 Oct 2024 07:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.169.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729841157; cv=fail; b=TSiN5IDVmxgyNdud7rnm8ttiyg0GJRvOPyomkqep+7BACV8/jP15vI+sG3uxz8iYkXqSzQ8cbnnVZ2NleLe++tWZlNRAoELT7ojx1DAiBvrBSsJ2LADqtsF9aCwHW8v1t3HYUrIOSb8y9/WVrE5viZ0VY50EVO+Tio9srtGk09s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729841157; c=relaxed/simple;
	bh=B96kXEZFRBvqsJAJyfCsR9aoN1BxSbq9s1OsJcFc/vI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UO8Z5O7fZvyioGs3wuPZfF53HIJO4V5xmewqp7YI91ZAaZ5ioVnpTnmPwVh5A6Dj4h0mNTcxzDH/5CKYqPsbo9kDlqn3pWs5lps2z1WjlrOBW+2f+Gt9I6h2dsyyMVa9+KT0aIXdHhHtsCmHyrv1OKV684JXb+97aBlx5TNReh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iris-sensing.com; spf=pass smtp.mailfrom=iris-sensing.com; dkim=pass (2048-bit key) header.d=iris-sensing.com header.i=@iris-sensing.com header.b=Pq6DFW5T; arc=fail smtp.client-ip=52.101.169.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iris-sensing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iris-sensing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oeYN3pQE5nrDaUMDZcb0euRmUJ5Wk1Qo0vBt+g8862kVdSfneWjWhSzRfLzM9c0ZGtk3xbn2OGuPhaPpgFTJhrJwYniajFJpPfXHW3Ij/FxSovPDdrI93JbWbuNSvBqt1fIG9TZp74x3RE4QvONYUvbDbzAm2SdtCbjPVmYhSBho5f2mnrgvWdJJlFZG4B99mBG63JM0AmSDKvm5IbfF9r/nC7plUzALaRIQKx+JhgN5duSNY9NT6dtAa3XZ8NZGghxks7dpighf8z2IWTKd6ewAWA9lpL9BWxQp7S6AunMJO6wmRkSg1zzzGfeZUPGAmBJxalSDbd1URC7XXo4quw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B96kXEZFRBvqsJAJyfCsR9aoN1BxSbq9s1OsJcFc/vI=;
 b=xpLx0n3hdKTHlmefnOCov4yai6SHL93eBUfSFTft9UC4DBXyhS8/JUB+kmZE4qq9e4NrW3rh/yQlCOeo6EE3P0ZEQ4rc8fVAoDkiXl2Fybt7Us4+OhOtxUnj5DpKcZFtFc3F+2kWQXIGO2vwi5nRN/1Yd9OnkvmMsQKZn+BEbZZf+DJmPkViPZWDhZ7kxEqVNvpBn800yb1cEUN3G7L8ZRhkrQTeJ4LfR1uQRb/haQns2dYoMsnNREapY+DpYB/2pnwK+LKAUSZTib5Pjt/N6bx+j0TSix67HKh3I1J0uVz39/agemK1Gf4sSfE3Uvc8liUCtrVCoP3Cxz/sNxqWcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iris-sensing.com; dmarc=pass action=none
 header.from=iris-sensing.com; dkim=pass header.d=iris-sensing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iris-sensing.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B96kXEZFRBvqsJAJyfCsR9aoN1BxSbq9s1OsJcFc/vI=;
 b=Pq6DFW5TsgypFNIt4QlCmML2SvKtH/EfK5el1wMsYqyDGGh0Uuv847sARk4dKqL/QZ2Aa3+d1+qVw9a9v0w1Yj/A5I6L54JKBgBJJenZC5fCz7vzgBlHGd88Fz5HdSKDAHTIHwnR60OmRDF17vk1NN9+hDGoM5SCcLuKOhCsPoX27la4wZqdtk56RWDvRHG5nywdc3yK86vpCaOWIbtYOAexZ2oN4MiPUAOdmvRVXrHgkMBVgViYOQb616W5NrgfkmIILR2IHb+j4FZl1c0IYmfVpCmHDu+yJ0gN6DXx+We7nNrQSiVcQJgtOmGlZ8ZVUFY9JKSkyM4cLHIB+AVikA==
Received: from FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:23::8) by
 FR3PPF63DD032A8.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d18:2::147) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 07:25:50 +0000
Received: from FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d685:f312:e114:519e]) by FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d685:f312:e114:519e%4]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 07:25:50 +0000
From: Erik Schumacher <erik.schumacher@iris-sensing.com>
To: "u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>
CC: "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>
Subject: Re: [PATCH v2] pwm: imx-tpm: Use correct MODULO value for EPWM mode
Thread-Topic: [PATCH v2] pwm: imx-tpm: Use correct MODULO value for EPWM mode
Thread-Index: AQHbJd+0DCsBjEpWYE6MZa3vNXpdIbKWZA2AgACuboA=
Date: Fri, 25 Oct 2024 07:25:50 +0000
Message-ID: <6d884afde9d41b6efff7be5f820f8121f38e8321.camel@iris-sensing.com>
References: <91bfd0c1726d2e6d10c96a3f2e141a7315b08467.camel@iris-sensing.com>
	 <wqjwdjqsjn5yngbkdpbinwtonxdpugy6n6nide7fcodhpto4hh@7yxigtrvvu2n>
In-Reply-To: <wqjwdjqsjn5yngbkdpbinwtonxdpugy6n6nide7fcodhpto4hh@7yxigtrvvu2n>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iris-sensing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB2809:EE_|FR3PPF63DD032A8:EE_
x-ms-office365-filtering-correlation-id: 8676be81-6cfd-4aff-b465-08dcf4c640a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y2ozeWQwYVZnajUvTnp0U0ZMdEFKRFAyalY2VjltV1h6UTlxenFmSUM5cE5N?=
 =?utf-8?B?N0FiV0t0Z1NjdXBMbTczcXJrRFlQOGZnb0doakFENk5za0hrOW16N1ZqT3dZ?=
 =?utf-8?B?Uy90ZzFCRUNsU2M4bWdJVVBIZGd3YWN3OGlUS1hkWVFCMFNLb3BRbk40NlZ6?=
 =?utf-8?B?OU92RGI5dWRpWGhCdmR3ajF5RTNyT2pKa1RWSXplditZSWdFR2ljZVdlSGpB?=
 =?utf-8?B?OWpDcTV6R2daSUpmR0tpTlNNRXI4Mzc2eG04Q0gyYWVUcjhDbzVwUlBpRzdl?=
 =?utf-8?B?Qlp2SE5YOXRuQzNPaElhSkRvUHg4cUlLZ2hBdFZHdnFJUk1udUgzS0tlN0Q4?=
 =?utf-8?B?bFhNa1dFRk9Ha2pkQlBMVWFwWklldGM1U0tDTldlNTZLOEFpOFRiZ0VDWGZY?=
 =?utf-8?B?eG5OTjVkQzlYbGZMUEkrbVd2U2FKQnJLUzkwQXJkZ1E3ZHlFYnh1UmlaMHAw?=
 =?utf-8?B?Qkl5YmFiY3o3NDR0RmJTSFdLc1NiL2RwRExqSmJDQjdFeW9KczRQQ2FROWpU?=
 =?utf-8?B?bTJmTWovdi81ZkRzanZyVkRIcXpvcEc5NjFlMDMxL2VSbHJwWlMydE1GMDNt?=
 =?utf-8?B?WmFFaEVJSVE2MmxEUVBvVkhpVklsbHR6eHF5cVdZSjlkTzVDVnl0ejE1b3hk?=
 =?utf-8?B?b0R5RGdmYjRRa2dtWG9lazIvRXhER0pXanFDNkxnSDljMTFOV0N6dG10YjFh?=
 =?utf-8?B?QnZoVGhoRjdUZDJXUmV4TTFIQllMTmNDQ0Z1dGFhZzVONUJLSXRCajBvT0pr?=
 =?utf-8?B?clIyVzBuWkxKYnh5UGRsMytaK0c5V29YRk55WFlZQnJJcjRwMVNhR0thSUFQ?=
 =?utf-8?B?WW9zd29udDFxSHowcGRVR2l2NGw4NGMrbkFPbVYzQnYrNnpYd0dGallPaTVq?=
 =?utf-8?B?SEtLNTArSTFKRjN4Tll6ZFh4dVd2eS9mZUtoQXNJMmduLzRyYkRmVTVZTmp6?=
 =?utf-8?B?UlNrMzFoTEYvbVRDZUlNR0JxdXZ4amhQMVNpcFdqb2g0ZmhuTkRnU0JFeG43?=
 =?utf-8?B?Mk5LTWJueWEvSkNYaHErbG5MSkI5RFljRXRCV0NQV2dtdGEvYms2ZVhCTHls?=
 =?utf-8?B?SWZwb3ErZmJGbzNGY3UxcFpXOTVIT2ZKUGRlZDhwdEpiMmFLUjIwQ2dZaUxR?=
 =?utf-8?B?TGxUaFFleHZjS3VDNXdvMUY5b0pERUdWNWVLRGZjZ3FTdEpqTkdqdG5JV1pm?=
 =?utf-8?B?dTRrSFR0ZFIrb0ZqNmRnOXdQZlBkNDlyZ2w3UTBtNjNSTUdGemplV3Jkb0xy?=
 =?utf-8?B?YSt5UkJPS3RMc0JOUWxENWZaL01ERktlZjc3OTVycWs0ZHkwdHAxbG9lcG55?=
 =?utf-8?B?cCs1QnBhN2d5VVRqZnNmcUx6UEJaVC95RVVRVmVaSnBGcVl4YVJzNXdid2wv?=
 =?utf-8?B?YWJOY0NHYm9OL3JvRWZIUWxPcHo2VnNEaUZWdzZVM0NpNVJaUkExNG92Wm9w?=
 =?utf-8?B?Rk16dDZpVlhvZ2FEV21QYkRnZDY0REFXQzhpTkxtQWd3U0wwV0k5NkR5RnJY?=
 =?utf-8?B?UFBVWkJ3WGg5d3JuY25tNUVmL1FHbityMldNL2RScWthaitLZkVJL1pqanho?=
 =?utf-8?B?cnNSMzl1R1JTWE1pZnNvSkY4bHpOVEdkUjIrM3NQdGdZek5VS0ZYaEw4ZUNq?=
 =?utf-8?B?WnpHMXlRMmtoRkQ1a3ZDVC9jbldRanJ1NW9SRlowMk44QlRNVmM3OGZYMG5v?=
 =?utf-8?B?V1YxOGtYMHllaDBvMllnazh1aUR3bC9SRUs4WnIxRkpoZjBiNi80eWtPL0pv?=
 =?utf-8?B?UTFDZkRqcFdaZThKSWROV1h5T3RIRnhzRGtMdElrc2hOalY4ZjVkcEI1OXU1?=
 =?utf-8?Q?MtJPLJlDda3zfs5EUDulEgAQe7l+Mq8EfS4lw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WmhXZ1BDNXhmVVdpL3VPVmwyVDhuNWVnSDh4TGYzWmNCVlBtUlFPZ3lKNVBX?=
 =?utf-8?B?dEJwbXBON1BnanREZldiSysrYzhZNmxSUUt2czc4L0s4TWJCZDdrRmhQNkx1?=
 =?utf-8?B?bFBycy9qMzUyczhoRXR3WUIxQU1LVnhNRVlub1k5QjVTM1I1N1B4bHNpc1JZ?=
 =?utf-8?B?SWhhZ2lLSkppRWptbUpWRTRad1pSZFhWNmt0d2tDRGZIUXVuKzBkYkU1RUJ2?=
 =?utf-8?B?Nk9PSXoxMFd6MUV5K0xPMENoVTB6UEtUbEt6TFRNa0NMYUg5UFFIdzJyVDF5?=
 =?utf-8?B?VVZ1cFdtSWc3ZFkxUWx0d3lsSktkNy80Zmh4U1RBQXFITUs1eG5IWmdJTnlh?=
 =?utf-8?B?Z1MwVTNHL1hYK01ibWpOcytIRWpLeElzcEtBWGFGRzhtVkxQRjlLNy8wMlZC?=
 =?utf-8?B?cUYxRG5pYmxXejdiOEpPTXY4RER2WXU3K2VUYWJUZnQ4c1EzaERMdVZRVWVy?=
 =?utf-8?B?b3MyMHVWR01XdnVuY1V1dkJUS0oxc1UwOFlOUmw0cVFtTUN0b1ByRk5EYXpy?=
 =?utf-8?B?SFNoc3FrL2ZrTWxqeHErV3RuTjduak9WK2t4OUI4ZkdQRHdacEhTSGJZYUps?=
 =?utf-8?B?bFhsT1NxenVmK1dDNU1JNFhzME1Wd1duYU5tNTQ4azB2TmlBNTlXTUh0K1lH?=
 =?utf-8?B?Z2tTZnBReHJveDYzbGd5TFdzL0NQS3BRVHZDMkNBYnFEbDlnTzZQZWZMUWxv?=
 =?utf-8?B?SXN4UjBFRkVUc2YzVUIzam9QM3RMYTV4NEJuRVRlN0hVYmN6N1VWNE9WajhG?=
 =?utf-8?B?dGVtNjYyUEhCWVJsTHlzL1hWR0gvYTY2L2hDTFJmT2hhN0dPMnM5cEE3RzFL?=
 =?utf-8?B?S3BKdHNMdDhPZmJNZTRTYTN5cmtuK3hOS2hsSmdncjBpemp6YU8yWjdXeGE3?=
 =?utf-8?B?Z21CcTNLTXprdXU3K3NLZFFpWkhIWUIzNjNFOFdxT3I5RUc0enNGT2NBRnVi?=
 =?utf-8?B?ZTV2YnJoaytTTDNvb21aU0c4V2sydkVVNnJ4RmJYelcvcFlsVEFPNzhONm1x?=
 =?utf-8?B?UHhwbW1qM0o1dHA2d0c2U24ySGV0cGVJdFNHbHFpd0I4K0ZSdDV1SEZ1SDdN?=
 =?utf-8?B?a1AwRnVuVXVrNWY5TnFSNmlGWkxUdUtlSGlGYUJ3TGptYi9xREpSVTROSHZ0?=
 =?utf-8?B?clJ3V0dteDI3QXN0VmUvNG4yMFFVNXBNYXJUVlo0MU95WTgzUy9uR05uTnlI?=
 =?utf-8?B?QUFIQjdmR1RQZytmNEh0RUFJQWZLOWV2SzJGcWN5dG0zbW94N2tMNkM0TWhU?=
 =?utf-8?B?VXdaTXZJV3RWc0VGRlNLOVJST1FUSjhONWtLQVV0VUxxOVFTd2g2bEgvekYr?=
 =?utf-8?B?Y2ZpT3hMQnF1QmpRYWhjZFJSSG5wdjNKM0JuUS9ISEl1UGhMVkRnOWpXT1hj?=
 =?utf-8?B?bWZUQUsvOE1scE1LTDdONjJKcUhJdzh1MFRsVThsbXZJelkwNHBYeWJGb1B2?=
 =?utf-8?B?Nkhpa0tucmY2WGVSTjFRazlCc2tMSXZjZHJOYmNhazJ0UUk3SlFCQzRJR2o1?=
 =?utf-8?B?bVlwZHptaDRtOGF1S0NrTFM4R2sxNmtsN1ZVMnNobmtoZWJmYVpwdFlyQ2Rl?=
 =?utf-8?B?MlVOSllDbTJraTF5SldvQm1HaS9qY3RwcFhaTlRDY0dOTWdEbi91NkRNaXBY?=
 =?utf-8?B?MTF1Smg2SHRqOHQ2MDBEcit3bi9PdUE0SWhRL1puQVowczQ1ZVpGRkZONlo4?=
 =?utf-8?B?OE4xUjQ1YzMxUWVYQzZQVGFGUmo3b2JQSHo1SlQrS0YzYkJ4QWgwZWNEN01Q?=
 =?utf-8?B?aWRHRGZ4SWFvVW9HWE10R2JvMGtNcEd4ekF6a1NZck9aRWVUcEx3d1paMlBS?=
 =?utf-8?B?VXoyU2xMRTBtTzlOTU9rSGxuclRuVlJBTWJSeEpOZFovZkdic2w3cnl5YWFN?=
 =?utf-8?B?ZTZ6VW9tSVlsLzM5NlNxd3hIc0VhRmxXR1RaN2p4cVF1MGlBV1Q2S3UyU3N4?=
 =?utf-8?B?M3g1L2hjQW5sa3RtMXVUKzdBYU56eFEwWkZtU0QwSEl6V1RMQkZCdGN4akxm?=
 =?utf-8?B?cGZQdHhvbnl2dkluVFMyMU9JY3J3VHA3ZFR4M0dIeTlxZEJPajNzMVRDZENJ?=
 =?utf-8?B?S05OTVFuN3JPT202d21BV3pSN0hpMW04RklmQUFCTndLZkt4Q2RacHR2SUJT?=
 =?utf-8?B?eGorUnMvSUhTdnZNdmxrbFkzME40a3lRV1F4b2ZHcDFaaU9UQWdOQnl6aEda?=
 =?utf-8?Q?6iOMYq1AY9PNUlPpcwHH9gY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C725C5AA31BE948B87F50EDADB8CE2B@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: iris-sensing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8676be81-6cfd-4aff-b465-08dcf4c640a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 07:25:50.4850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 963f3913-ffae-43fd-856b-2dfd3f6604e3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NeY1IGKLMMvCuYvVvuXuZYNQJq1Ju/67LlaO6NSXNd+8aNAOUXVl/Di2Ydh1SbLo35p7JIOJUAj4N/bgrzgeW9CVda7w0iE2dQD2gwwU6j52h7V0K27LK4YestfmbO+9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3PPF63DD032A8

SGVsbG8sDQoNCnRoYW5rcyBmb3IgdGhlIHJldmlldy4NCg0KQW0gRG9ubmVyc3RhZywgZGVtIDI0
LjEwLjIwMjQgdW0gMjM6MDEgKzAyMDAgc2NocmllYiBVd2UgS2xlaW5lLUvDtm5pZzoNCj4gSGVs
bG8sDQo+IA0KPiBbZHJvcHBpbmcgYW5zb24uaHVhbmdAbnhwLmNvbcKgZnJvbSBDY10NCj4gDQo+
IE9uIFRodSwgT2N0IDI0LCAyMDI0IGF0IDA2OjQxOjA3QU0gKzAwMDAsIEVyaWsgU2NodW1hY2hl
ciB3cm90ZToNCj4gPiBUaGUgbW9kdWxvIHJlZ2lzdGVyIGRlZmluZXMgdGhlIHBlcmlvZCBvZiB0
aGUgZWRnZS1hbGlnbmVkIFBXTSBtb2RlDQo+ID4gKHdoaWNoIGlzIHRoZSBvbmx5IG1vZGUgaW1w
bGVtZW50ZWQpLiBUaGUgcmVmZXJlbmNlIG1hbnVhbCBzdGF0ZXM6DQo+ID4gIlRoZSBFUFdNIHBl
cmlvZCBpcyBkZXRlcm1pbmVkIGJ5IChNT0QgKyAwMDAxaCkgLi4uIiBTbyB0aGUgdmFsdWUgdGhh
dA0KPiA+IGlzIHdyaXR0ZW4gdG8gdGhlIE1PRCByZWdpc3RlciBtdXN0IHRoZXJlZm9yZSBiZSBv
bmUgbGVzcyB0aGFuIHRoZQ0KPiA+IGNhbGN1bGF0ZWQgcGVyaW9kIGxlbmd0aC4NCj4gPiBBIGNv
cnJlY3QgTU9EVUxPIHZhbHVlIGlzIHBhcnRpY3VsYXJseSByZWxldmFudCBpZiB0aGUgUFdNIGhh
cyB0byBvdXRwdXQNCj4gPiBhIGhpZ2ggZnJlcXVlbmN5IGR1ZSB0byBhIGxvdyBwZXJpb2QgdmFs
dWUuDQo+ID4gDQo+ID4gRml4ZXM6IDczOGExY2ZlYzJlZCAoInB3bTogQWRkIGkuTVggVFBNIFBX
TSBkcml2ZXIgc3VwcG9ydCIpDQo+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiAN
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBFcmlrIFNjaHVtYWNoZXIgPGVyaWsuc2NodW1hY2hlckBpcmlz
LXNlbnNpbmcuY29tPg0KPiANCj4gTm8gZW1wdHkgbGluZSBiZXR3ZWVuIHRoZXNlIHRyYWlsZXIg
bGluZXMgcGxlYXNlLg0KDQpOb3RlZCBmb3IgdjMhDQoNCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvcHdtL3B3bS1pbXgtdHBtLmMgYi9kcml2ZXJzL3B3bS9wd20taW14LXRwbS5jDQo+ID4g
aW5kZXggOTZlYTM0Mzg1NmYwLi5hMDViNjZmZmUyMDggMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVy
cy9wd20vcHdtLWlteC10cG0uYw0KPiA+ICsrKyBiL2RyaXZlcnMvcHdtL3B3bS1pbXgtdHBtLmMN
Cj4gPiBAQCAtMTA2LDcgKzEwNiw3IEBAIHN0YXRpYyBpbnQgcHdtX2lteF90cG1fcm91bmRfc3Rh
dGUoc3RydWN0IHB3bV9jaGlwICpjaGlwLA0KPiA+IMKgCXAtPnByZXNjYWxlID0gcHJlc2NhbGU7
DQo+ID4gwqANCj4gPiDCoAlwZXJpb2RfY291bnQgPSAoY2xvY2tfdW5pdCArICgoMSA8PCBwcmVz
Y2FsZSkgPj4gMSkpID4+IHByZXNjYWxlOw0KPiA+IC0JcC0+bW9kID0gcGVyaW9kX2NvdW50Ow0K
PiA+ICsJcC0+bW9kID0gcGVyaW9kX2NvdW50IC0gMTsNCj4gDQo+IFRoaXMgbG9va3MgYm9ndXMg
aWYgcGVyaW9kX2NvdW50IGlzIDAuDQo+IA0KDQpUaGF0J3MgdHJ1ZS4gSXQgY2FuIG9ubHkgYmUg
MCBpZiBzb21lb25lIGlzIHJlcXVlc3RpbmcgYSBwZXJpb2QgZnJvbQ0KdGhlIFBXTSB0aGF0IGlz
IGxvd2VyIHRoYW4gdGhlIHBlcmlvZCBvZiB0aGUgY2xvY2sgZmVlZGluZyB0aGUgUFdNLg0KQnV0
LCBpdCB3b3VsZCBiZSBhbiBpbnZhbGlkIGNvbmZpZyBhbmQgcmV0dXJuaW5nIC1FSU5WQUwgdGhl
cmUgc2VlbXMgdG8NCmJlIHRoZSByaWdodCB0aGluZyAoaW5zdGVhZCBvZiB1bmRlcmZsb3dpbmcg
dGhlIGludGVnZXIpLiBJIHdpbGwgYWRkDQpzdWNoIGEgY2hlY2suDQoNCj4gQmVzdCByZWdhcmRz
DQo+IFV3ZQ0KDQpLaW5kIHJlZ2FyZHMNCkVyaWsNCg==

