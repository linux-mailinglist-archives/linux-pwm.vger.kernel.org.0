Return-Path: <linux-pwm+bounces-6456-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90949AE1A8F
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Jun 2025 14:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1613A3B8D0C
	for <lists+linux-pwm@lfdr.de>; Fri, 20 Jun 2025 12:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343A528A40D;
	Fri, 20 Jun 2025 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eI4OGlMY"
X-Original-To: linux-pwm@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901FA285412;
	Fri, 20 Jun 2025 12:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750421367; cv=fail; b=fjUn3YfQPBkaygC1qXzcyoSUJadzuVgsa+izsLHK+1bUlNtJKMNt+BiGbXZEDkS4xFkI+phAUtzMGviLoog1mTij0Cc4AF+cQJQYWTGhUSpE5K9sR/rlDUsrlzZG5mPa/cSlH7PWo1S8IBqyQm+9TB8U297obmRm0n+ewzeCtn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750421367; c=relaxed/simple;
	bh=xxBvBGUuyzPmvbi6vKMnTFKd5+NYfHxaVd1hfFOWB28=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qYXNmEqAEvgEziCiz9Iv/qEjOSlll1s6fdjbENfl234d26GXHRqYgC4gqg0G1mxEN+doEvEh+f4TKZ0d8SaU6UicsoShr9YHTi7bRnW5vJnIWP6OWszcjR2Leyq0ylm0devAJQMmJdapvGPyzx9+MLm6/rA1yiZKM1jdYDB+uWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eI4OGlMY; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bv1p1qzWqrLxoaYLbr6+jm/G4/Lwcvyb2Kn5rR2Xjsa1Le5K+lCTNHlukGzXtZavi6N43DQrpf7o/hY08d0FH8PYzCak3HbaVqKYtYPI7SKklh485vaO8LlDu4RBnALZQrtEI4zQuRDrRKkPGB1o8zqKGUdVfFuRiKSc9Xi4XJS/SnFPpOyDdOXMzRV2ZKjk4CQngOkSF/IU4p/qxtkhiQ2fJYp+LQaC+tLw/SJyAnU7plPnWpZFW23Wyn0/i3STHEpOLMZrlCF+N4o9N0GiSoXEc9Z3aiU1r+BAJu8ODfbfKM6J1j8NLHFe3Ta5bEJ5qGCpsvHYdyy43RKhKwm9vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NPUbXozireUW8qyIUSqGVxFzb6lHW1IZfIY9VbbzLc=;
 b=Mm+RwasPd6fR+myJ09a6mxAj8A4ZOCzB7Zo6wDjSozVTntkdpXVYIVWPkyoDkHNKguq7OAbkjRQ0JrnZOUTUVtA5xaCQE8f98i36FrBE+DiI5VkcSsk14zlcKIQYX8Z9s8bN7QSjyr4w0+PrOSatPatJumdFxTufFnIdHuWUmqQoMQdvG8ww/Q245ggbIfYn6ubl6vk/WbBGoolKZvc9vW0mNflCv7Opaehj2KaNj13xNofNWOaWM+OWrkePu7G1e2dfcwdX9YMx+zvhksX9srlgksJf5tdC9BkXsTaPLgmTK69OxzYYR8R8p0ELfBovNf1P6Batt58Wok613m+ghg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2NPUbXozireUW8qyIUSqGVxFzb6lHW1IZfIY9VbbzLc=;
 b=eI4OGlMYnj+IokGfhO8LjE9dBbkJFXeUkqjaFsyAmmwDXO5cDSAwFOIf85VRPEuAyi0AyIlsHGmXseBp0J80loxCYtcIn1w5KIdLph1R5Rm+wwONgVhaOa6TThqNBPEHPdmhNjOxJFmUc8e0ZjCAehYEdQcJXoIbQWJRF0DEQ1g=
Received: from DS7PR12MB8249.namprd12.prod.outlook.com (2603:10b6:8:ea::16) by
 SA1PR12MB8644.namprd12.prod.outlook.com (2603:10b6:806:384::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Fri, 20 Jun
 2025 12:09:20 +0000
Received: from DS7PR12MB8249.namprd12.prod.outlook.com
 ([fe80::eeb0:6d7a:ce8d:a5cb]) by DS7PR12MB8249.namprd12.prod.outlook.com
 ([fe80::eeb0:6d7a:ce8d:a5cb%6]) with mapi id 15.20.8857.019; Fri, 20 Jun 2025
 12:09:19 +0000
From: "Rao, Appana Durga Kedareswara" <appana.durga.kedareswara.rao@amd.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>
CC: "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "Simek, Michal" <michal.simek@amd.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>, "Vanukuri,
 Meher Thanmaiee" <MeherThanmaiee.Vanukuri@amd.com>
Subject: RE: [PATCH v4 2/3] clocksource: timer-cadence-ttc: Support TTC device
 configured as PWM
Thread-Topic: [PATCH v4 2/3] clocksource: timer-cadence-ttc: Support TTC
 device configured as PWM
Thread-Index: AQHbZ0HQx65y/GwqLEerJm99AExLJrOClJ2AgIpUmbA=
Date: Fri, 20 Jun 2025 12:09:19 +0000
Message-ID:
 <DS7PR12MB824987018AAB745E38C638728F7CA@DS7PR12MB8249.namprd12.prod.outlook.com>
References: <20250115113556.2832282-1-mubin.sayyed@amd.com>
 <20250115113556.2832282-3-mubin.sayyed@amd.com>
 <hwnhz4yr6vzz3oav4gq7qptejjy3rdwff7iveawaxexf3tbngr@pnrxi6jkpw3k>
In-Reply-To: <hwnhz4yr6vzz3oav4gq7qptejjy3rdwff7iveawaxexf3tbngr@pnrxi6jkpw3k>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-20T12:07:15.0000000Z;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB8249:EE_|SA1PR12MB8644:EE_
x-ms-office365-filtering-correlation-id: 686b93fb-d1f3-493d-6104-08ddaff34951
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?SPZbRTBS3+Ach+ksA5e/ke7A9lwq8oup9X3IYoSB1DFsDxsKYjeqoiWwGF?=
 =?iso-8859-1?Q?/kz26Oco3U2+bWyCii0f1cpOZagw1mPxRRsk6b5MahCHNa924OwTrzX778?=
 =?iso-8859-1?Q?eEa9UC7CrlTASV7NLbTtjB5DigfbfCJdp8UKRmKJQg1TAVl1eUnBipLhs6?=
 =?iso-8859-1?Q?R/Po5vqpws3e7ssMsnYh33uKDugYdW+vpxESddQYrlUmh3GgPiLL5kj0SJ?=
 =?iso-8859-1?Q?sMlq31Y8L4leCyJSFmUVAmfrkZV6A4HX1IVmaQYELETgXCQDCdzqByt8+j?=
 =?iso-8859-1?Q?cd5me04Mbi9llKeNgRzJ8Jc6M6zSKyCYRF/WQIMyz8TtzUDcUYYMl/gQLk?=
 =?iso-8859-1?Q?yYj20B3wlBADJbT8kyk45910lmbl+NQdHMaMCAbKqDM0H9BpYS/6b9rntw?=
 =?iso-8859-1?Q?Pi0gZzVVKJD3d2yoKrj+dPZBFitSf+Tbem69+BSoHgLxlM3Kb5ReINEKYA?=
 =?iso-8859-1?Q?vlQGsWIHcQ2zgLnTqAsocHSQCDYZ8ye5k/5IwLKnMcRkUJS83NEOBUi++C?=
 =?iso-8859-1?Q?TDGiyPVjod3ad3g8ZSugUvzQeF40t5vU3HFIgrlBZBwx/zlUMUvYhepnvR?=
 =?iso-8859-1?Q?7hgERTJtSh3jA2RxR6GAdk1048SAO0UxklMHSdUk1HiWUnFQHpH3oHn0HM?=
 =?iso-8859-1?Q?hrCKbmceDabwJ7tJ2c7324Gksv//5CXe0s8VUHFcf9MhYRY4eSLH1W9lZJ?=
 =?iso-8859-1?Q?LitBP7vUUyskEyzAFrS0wyKPC0kMmmvyum0ieu30SP9/dqh5k73JD7wcIy?=
 =?iso-8859-1?Q?69xePssG95/2KtqyKF4m7s2h+B/aAvpY65YiQvCXyL+EL3kVaa0nn65SOO?=
 =?iso-8859-1?Q?0BnVq2b126hRwgtYXNNLsgNKQrEbIwt1/U9netNpna7iXK0UOiy5YVz6VJ?=
 =?iso-8859-1?Q?MFoFIjomHrPc3Ye4hwdGJvrFRByIeNoObK+jWqSm3pEasiuOVg/Wl2aRM5?=
 =?iso-8859-1?Q?EGb+yPVnPpkvyhSQdwXTWMKcITB6FftqhWXcFOKuXtKVbzefQlsM5JYNE7?=
 =?iso-8859-1?Q?wIS+xH6+Ee8lluU1/GegTFXIucArUUWvTmXeUujxih2YdA7Vow8FqCxS8H?=
 =?iso-8859-1?Q?4QsJDOxNrs7kpXJ3PvCFGssxzzexTeZYAREZVUUdJRFLRySb5Al9H9T9AG?=
 =?iso-8859-1?Q?ARqDSEAQN4Ag31+aVcE+oJHd06pV+I52OwEBgcw6LqmSbxH13aTVXbkOuG?=
 =?iso-8859-1?Q?Kwbe6af3if1M1dYupe+6SrMkG8EErybS5nA4QRYW/WveI1JzS9azEqT1X7?=
 =?iso-8859-1?Q?2urpVa1uxlfjAO5fTli9ZzZxBaFsp38iw1MevNL3hxNMYjcIY0imrInhrk?=
 =?iso-8859-1?Q?/nJGGu+M29G9ts9qt6m2Wgf9steQ6oS8teUP9jpq/K5rxiDG55jAr75J2U?=
 =?iso-8859-1?Q?TB4RaNA4dXpdetpvrXAHxbQryq70advMn2cpNtkUZ+GoXm6nhMMjM8woz5?=
 =?iso-8859-1?Q?mH1YSXoSA74kwSew0Zr/0YMYkhrvBU86dHJyhm5W/n8W3YLtg0CNQ/g0Su?=
 =?iso-8859-1?Q?d9St12TxcDq6EpJsgnld6hQSuBYTYOa2tqfe2wzw74DU+rxRDfqpgcwMmg?=
 =?iso-8859-1?Q?nMhbQcU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8249.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?6ZB7MwEm2gMUdQ6yHb3D9AUi6WXBXX1oSc266GIhDzXnCcs1BoBGkVcgQA?=
 =?iso-8859-1?Q?3liSS89u/Gv4yKGL3gVGtCzQkieNlpfv0xAYHau6zRclx3YgSRRFUfoTcY?=
 =?iso-8859-1?Q?ZeQAEYZOtUi1ti5bvnNlEV2Sbgi4meTRCdzMH9A54qJ2jTWNBHhfyxAmR9?=
 =?iso-8859-1?Q?LAjiIgUThR18/3hXR7o7RauvQhabebTwGiIKGyye6JEtdx2BMC6Va70PKr?=
 =?iso-8859-1?Q?EunXqu7w9TIRcwSbKax2yVSADeMvxJCkV/iKLwTevD8GcQlfjvoHSnwTiE?=
 =?iso-8859-1?Q?dc4zCkEGbmlAtY15hWKsM4rYIjklD5vgImmaX8A+PaqqmSIQbVWX9hP8KI?=
 =?iso-8859-1?Q?yp143i1VXoP50RtsmCLdZOEWKYBM7QdbfF45gJmofnEOvjzT62VD3uMyf/?=
 =?iso-8859-1?Q?PPIWf/16dBj3P2eSnia7iRGU4tE1nCVlEnJ+hqBe7DqUikIb4pyK/tR1+S?=
 =?iso-8859-1?Q?PGpRvWiS35Th6HtiDhbLgu50mVBDDjzqbx0PzAP8OL0FJt5/5SaGjle2En?=
 =?iso-8859-1?Q?GTZT6n+BYXIhTVzBRbadATSdJhsN3ouxyB/lwwZ3i/E1tuQp8AmmGJugOt?=
 =?iso-8859-1?Q?uTntiAa1Q0spFIAos4w4kQziqiK9i1zC1h9OG1m+xvaX2JuPKBGScwMo7s?=
 =?iso-8859-1?Q?e4RlR9g5Wfr7C/qmts2iNe/bi4O3OItqFJKWnq5HZBJnRT+sZV0BF2fgUO?=
 =?iso-8859-1?Q?5S7hdPKKJ/Dh7TsFujUeDgXCnpitl2DdYaszRxpdar/jywVLw6LzdR3PKL?=
 =?iso-8859-1?Q?qZn8Ar2x9wReDxc/OCk9gt05yel8y0Ntsnw54AjtlQosfxbVzDoYPAe6pP?=
 =?iso-8859-1?Q?L3wBjzQvCRXJYKtf0Z0ZSxuaIVAYsaIqxHn2JC1iSEx6+R0YzdawOmYdjH?=
 =?iso-8859-1?Q?5sjaufXwHSIE48SFWxgN/L1Fr1w0fYxm5yrLyx3YGe65YxM6Adi7VZAi41?=
 =?iso-8859-1?Q?Rs+LWBVcry9KyfZWmXl5/yPvEbthkanEXCwSizl0gx/zqoA9td1gGlIXHx?=
 =?iso-8859-1?Q?eOTFSNQVJ9u+uOxC+77/DM6EyqvBkVU/eNf8qdn7DKiyceCMMICXsDo60d?=
 =?iso-8859-1?Q?ULFik99KG9K2FEAMMxw4F9lh7lOwFEy3K/nKum9THUOYVpZ4b0Lj976BPq?=
 =?iso-8859-1?Q?iVIHMfkSUMzMn8lPT5lDzvHz4ASw1iWfAPgVryW3EIAFu4y+taVVb1Vt1F?=
 =?iso-8859-1?Q?UDU1CO/G9MnUEHVDyWUyEfkHqH0Yl2e2QGtUra9q4OSO6ZiIs6KFF4Kuot?=
 =?iso-8859-1?Q?SYZDkwyMlk+Tp9gqcJl+OWJprB3AHoGQEgv6W3RFrfFU0Q/AFOB3Z4uCmM?=
 =?iso-8859-1?Q?xkWFlCFZZZ28EO4s9DkeTWCqYMiYDAxjzkdHJKffedaX2yTpzvZtm5vvV4?=
 =?iso-8859-1?Q?uCVldokQeBxOolq2NQRytp9uLEeHkIyzt6SjmNx6tAKrmBRAdOrtZcUQAf?=
 =?iso-8859-1?Q?4cGj0dDTl7L3rkvND3UXtgICcJjKoAYEaW5UPSJCqr8Hemm3OXDY6T0mPS?=
 =?iso-8859-1?Q?oj703AkmXtUHy3Uzl98EcfhUK8AQhoUwHMKBbykr1GSyOLnTaGZFdrw3SK?=
 =?iso-8859-1?Q?3gyG8vZAtQDGv0DOy/B8U8HD8TwTg9SuR2/yZzOq31kQZLHY5dv7tkgHVt?=
 =?iso-8859-1?Q?A96+5yvQ33Gb4=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8249.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 686b93fb-d1f3-493d-6104-08ddaff34951
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 12:09:19.8041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1X+/A8q0uWQRz2xQU3tW0yNA7atgNd/Q3fnZ3m5gIEHvRK8YmiMy7avMhqIe8Jck
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8644

[AMD Official Use Only - AMD Internal Distribution Only]

Hi Uwe,

<Snip>
> > +   /*
> > +    * If pwm-cells property is present in TTC node,
> > +    * it would be treated as PWM device.
> > +    */
> > +   if (of_property_read_bool(timer, "#pwm-cells")) {
> > +           #if defined(CONFIG_PWM_CADENCE)
> > +           ttc_config->is_pwm_mode =3D true;
> > +                   return ttc_pwm_probe(pdev);
>
> strange indention. Maybe use
>
>       if (IS_REACHABLE(CONFIG_PWM_CADENCE))
>
> This is an unusal way to bind the PWM driver. I'd prefer creation of sepa=
rate device
> in the PWM case. I wonder if it can happen that ttc_pwm_probe() is called=
 during
> boot before pwm_init() completed. Or use an auxbus device to distinguish =
between
> timer and pwm?
>

Sorry for the delay in response the upstreaming of the TTC PWM driver was p=
reviously managed by Mubin. Since his departure from the organization, I wi=
ll be taking over and continuing the upstreaming effort.

I have reviewed the v1 to v4 patch series along with all the associated fee=
dback. In response to the concerns raised regarding the use of auxbus, I wo=
uld like to propose an alternative solution: registering the PWM functional=
ity as a separate platform driver using a distinct compatible string. This =
would allow the PWM driver to be probed only when the specific compatible s=
tring is present, while the timer driver would be used otherwise.

If this approach is agreeable, I will proceed with preparing the v5 patch a=
ccordingly(after fixing other review comments along with this change) other=
wise will explore the auxbus device please let me know your thoughts.

Regards,
Kedar.
> > +           #else
> > +                   return -ENODEV;
> > +           #endif
> > +   }
> > +   dev_set_drvdata(&pdev->dev, ttc_config);
> > +
> >     if (initialized)
> >             return 0;
> >
>
> Best regards
> Uwe

