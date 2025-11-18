Return-Path: <linux-pwm+bounces-7638-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EC2C6AD81
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Nov 2025 18:11:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 28BD84F5484
	for <lists+linux-pwm@lfdr.de>; Tue, 18 Nov 2025 17:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94CE377E97;
	Tue, 18 Nov 2025 17:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="GAhphxTk"
X-Original-To: linux-pwm@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010063.outbound.protection.outlook.com [52.101.229.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FC9377E8F;
	Tue, 18 Nov 2025 17:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763485421; cv=fail; b=pxi8lcxvI1mno72YRhaNBlUh/tnjGABeu1fZzKcbqOvGPErA9v5lZp0xveEqog0m+nb7BvlG7sI78khYvaboVlGiaNd9j6JSpLc/hMd+QqJjukLhGJuXSamOTEyzyHaFbPoW0x9jVVXhSMvq/NtODnl7oEq8fJglKpSt8mSC9io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763485421; c=relaxed/simple;
	bh=mhZPqPlugR4k7elq6rMO1CYJslNbhxJSCIaV29rEiY4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HV/4maUJSEVsuMtgKIt06JjIWowwjqOCU7fqUJNs7MQqMwPaL0EQnDYsexOXHZdiGncM6GN6e00AfA9rJ/rBUXRJcKilz7gvZkK5oGSD9wFwVktlCAen3iI6YJsuFwwhA9OPZ+Lbym4hSfO6PvJGsA+M6gJGnYUikwhqYPW7Ey0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=GAhphxTk; arc=fail smtp.client-ip=52.101.229.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXqXipD1lj6vY4WGwN6XcUAGRZY4njCGO7ymUNvk6A79fAFGVC8OgPuYQnfRQrmjQRHhGW+tg2wQR36MnQFj82+iLOm8DFCLdsL6XHiVQRqcpeZPkr3Ccd9spOImiugwl5ob6MLLnDIWyLA5oZiUo730PDhMfB4u6VuDJoOrhpeoxT7VJdsvh9a+1YTnbvSlRtRAHEAu/fxaFLU/xOnUiLZYa2Zxl3awrdRTNyRwBMp8ChC5RULAF4h3qvQzetSNmsi40PuKcdXjDjmj/5XM1IxR3SszqcRqgQjQLWSsQKNg4sfzZNFhOeYn45iHbVOQiM/hmqDib+mHaYJgusuDJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DS66ErokKsEv7bhhQGZltj5LO0wVR6ACHyGoGYQcprg=;
 b=AmEJBkZOCaQ1RZNBlgFjYxdZFGGf1ZGaExkaLrSsS1TiUy0LhHqQzpRAwWQCSN54+Qk0pBWkfandsZ5inKLgOlf4yN+RHX+MkNPTcU6M4SsIewPdgHIiHQp3n6HtMEQIRxO0FfPeXa4DEWtjzrfi18mHmg0Tnrf0900vGsLxUwfwmSjs/LEWsg7cqSGOdPLZV93b5mrySj9+sZH2NTiudVg+8ouT2MQxDCcsbw8PCc69OlVQVkWi6O0j+053Yo2SKMom8tRqdq8cRDrSGl+62Z8CRNfDgjyuxbSA4Hljf7bVy4ly1VtqeP9pK6G9J4f2LKmKTHGl/VRBUvQxaXnYFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DS66ErokKsEv7bhhQGZltj5LO0wVR6ACHyGoGYQcprg=;
 b=GAhphxTkLfPD9JQrnsXfQ0ZkdTgswEOyrd6jHVEyRTo7QX8oX8Rd9T7mfWHxD4O9nHSdkeeKaMGiXYPrtaZAzt0v6bLOZ2crXOOoB6W14ZdGTWbh/oonGkFHjj9ehzMZYnmSECjmi1uTXGJYFfBSSkVXuSRspSJ2gEZLnCT6VCk=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB10772.jpnprd01.prod.outlook.com (2603:1096:400:2a4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 17:03:34 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%6]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 17:03:34 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <ukleinek@kernel.org>, biju.das.au
	<biju.das.au@gmail.com>
CC: "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"stable@kernel.org" <stable@kernel.org>
Subject: RE: [PATCH v4] pwm: rzg2l-gpt: Reinitialize the cache value in
 rzg2l_gpt_disable()
Thread-Topic: [PATCH v4] pwm: rzg2l-gpt: Reinitialize the cache value in
 rzg2l_gpt_disable()
Thread-Index: AQHcVXbT1K+z1LyjQk+ztnXMbmIpvrT2hVOAgAIJYkA=
Date: Tue, 18 Nov 2025 17:03:34 +0000
Message-ID:
 <TY3PR01MB1134679D611D611AC2CED72F886D6A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20251114145606.200948-1-biju.das.jz@bp.renesas.com>
 <ppqewbxcvsqcpp7met6vupmvxaftfjwiefej2c25jw4hoe3c23@lyh7saabrhkd>
In-Reply-To: <ppqewbxcvsqcpp7met6vupmvxaftfjwiefej2c25jw4hoe3c23@lyh7saabrhkd>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB10772:EE_
x-ms-office365-filtering-correlation-id: 7adbad08-eff0-4e55-a1fd-08de26c46873
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?4Pya39DcwiuP1UVNsItHB3vJvueodlkBKC+vczPCKbG9DeJl1+8A64r9h3?=
 =?iso-8859-1?Q?R+E9jzca8kuDE+6eT+3+09/7t3zP4pXUbwB8Tb6OqFJo8CXTnLSo9xA8BY?=
 =?iso-8859-1?Q?7lN0a9erv+/PHK4JnFaxtSHzL3bOBoaYyed5JN9OdSyGEhL/VmpwFaC1Rl?=
 =?iso-8859-1?Q?sf18s4feI6xAerdG+MlXmrkv60UgI2Vos2hiYSEbleNJ7WudbcFz/YsQoS?=
 =?iso-8859-1?Q?EyUR2MTphVA90lehxCYXIbfU1NW+FZ2B++nCZNFcfM+9xrh62pYbWQoVXr?=
 =?iso-8859-1?Q?9QnIMJpqtlbDZERRBbr4576fF09JDZC/HtY1Fmh9judCCF2JW4VDGxQ1Xy?=
 =?iso-8859-1?Q?npePhSRVFYNV2saRvqneSqVRjYzN8DgttComQI+hMs6SPYnhz9RyBwOByE?=
 =?iso-8859-1?Q?9+jDxuJbvZTkE6Ic+VWyQ23smHHKBzWkUVV6NLD9QRD/IXdOIgwzavpBip?=
 =?iso-8859-1?Q?+FwmFGLv9sAnvSQiEeI/2xPTSn4wqPn+8338AMK4PQfiqTuPK9s75Ik1nA?=
 =?iso-8859-1?Q?xGntl5dfpZWCXJ1y/58dbqhVYOHP+jjaHEDRUPdJ+LC6B3Nrm0alcVsYSU?=
 =?iso-8859-1?Q?V1cWPu7bHeFOv4bNKR798lxjE8m7PtaMOl0Wbr+AybtNPFmc0w6IydiCa7?=
 =?iso-8859-1?Q?8rWuFnV/pE9PJCIlHySouNHkLPWMPINdX14Chk3jUqGZOghYXlbwgbq7s1?=
 =?iso-8859-1?Q?UpEK7NtnKPVqTeE+5+OPMmYUodUNB9icO9FQTSSwB4Rqnrn8uqjavVt74G?=
 =?iso-8859-1?Q?x4c76AdBBD8DqdmJM+QSoKPfDjvVZd9lgZx72aZyikE7OR56P+gdrDLhHN?=
 =?iso-8859-1?Q?ZXG9dlC/zJmYb7ESv7bGTgewyDfxX2WADupJK2VOnPDaZ/WPJT13wI/lX0?=
 =?iso-8859-1?Q?AvMK6JP7M4WrObr1QhP89ZlhAfZKab6vk1RMPElSjmOas3bFkmvo4cpp+Y?=
 =?iso-8859-1?Q?iL5pgqIno6RuEoxcjjrW6LWIg4pX0S8Gn3xx/LzF3o/8TQi5dKKSUiBodn?=
 =?iso-8859-1?Q?xrM8kGLdOm4pCvMfIzd/PBLub4VB+tVFcbiQfcu+NPgWd1CBvAMjzMFPHB?=
 =?iso-8859-1?Q?Cx+9LeHqcbHavkf2XNPIoPQf7KTF3wdwfXRPFx+3TMbJy4fSoOHvKL1X4U?=
 =?iso-8859-1?Q?gslapM36tPFIL45PkpvLA4bHrr4Y76ftDRw7wJW62kjoWnKL9O4SDugkJ/?=
 =?iso-8859-1?Q?JLlgcP+eXyV3r6mDSIXCv29Dzt9I02ONREFFcPzxRJTk2f5C+1yhAcrEFM?=
 =?iso-8859-1?Q?l97ulvo0CMIUcjQ+PQxCpyFDRpGNI6bvbGECFrkQ4mijA3nK1wSpSU+AqI?=
 =?iso-8859-1?Q?URgBYzGzUq/7pGBU/v7I7FmfnBGXoespxhfUbg6FWgoUz/hz2axFJ3gGaq?=
 =?iso-8859-1?Q?gCTHsBJW2CrLSvD6iETHYrySVM/O00+HGwWToUx0jh7LRyxhSawgcJ/cdr?=
 =?iso-8859-1?Q?bf1b1k5E3sDNCRnACw3n/vW2aHg4WqUvLTdWlwDmQNCrzysxmhQkOA2NEV?=
 =?iso-8859-1?Q?2P4Wx053pKTTHBwjc5f/yg70nNzxUiJO4njDVUkTMrEDQUIrIot65QGGhe?=
 =?iso-8859-1?Q?0k5Xh2Al/wjlAYCPGln8JJT/ZwiW?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?DA7vow04HnvCsa+tKGaY89XfT7v1P4nAuSN96aM1ead1Y0cNOcg8UuUe4A?=
 =?iso-8859-1?Q?eCNKOQLfMoQ41GCql2fnpTdobY1Jj+DkHX/ozqhhy34nuiDh8dRDNeb0ZP?=
 =?iso-8859-1?Q?7piRQ214caDYe/83lCsEAxG/O37HwdqucXyDWM/Fr2S6bcXqrYSlUw0W+M?=
 =?iso-8859-1?Q?Urum/QI4g7R9MB09GYcBMB6H1z6ixusPZZdpQ2VEptNgfZ9awVkz+H9qku?=
 =?iso-8859-1?Q?9EY2MrCS6knwXvpFvrtR39qACRlptSrw/gPUXyiYVKfwtRz4+qgVTr+GgE?=
 =?iso-8859-1?Q?eLi3L11od9Qnrs3kaFJ+9q5KeFuqpiFuFMhzJH7Xtr1Z2+56i7VSqzw5gG?=
 =?iso-8859-1?Q?nG2bChb/S8BhHh/VGNNVn1FoUrebsp54NcnE+FNM2I87A61oD5rkSHbDYX?=
 =?iso-8859-1?Q?unbJzILZjj5h5tuX7J4+8Ywraf5xStJzYt49G+Yzp8FYpiCAZNHP52ReNV?=
 =?iso-8859-1?Q?UiSbXFs5kAi8rdR5By9fOhACxkn4UYaqDsr/twb7ymzfudzMSrNLqejoel?=
 =?iso-8859-1?Q?uGof+UkIvdUP5T90NHDls7nqXm7LRlhNXrQiF/LU7br8o60shu9ZnBNYtn?=
 =?iso-8859-1?Q?/4shAnv12hzvOfC9AldhH6NrLyZ5ihCuSeFEP3VI+ZfONFMz5B8lDS9kOi?=
 =?iso-8859-1?Q?UB3dUf5XTtbbxiPpqd33u6Lcqv0L2RA2bxiTEu2/C2+MW9Go/j9HKgC647?=
 =?iso-8859-1?Q?Piyu0lEJwuDo6RtpjfsAr5Bo0sNlUYM1mUfkF0fhrc5qJErWgaWK7L9mjs?=
 =?iso-8859-1?Q?kMty+cXxAQDPibCDpiLMURyj/C7C9FoTvLTQVeqB7yJR7fUlh8Sp0dM5J3?=
 =?iso-8859-1?Q?TbOz43K6FZtrIW5LijJEYU6aRmyH91hHrIC+SKdfYdKLoba/dr0DZN89vV?=
 =?iso-8859-1?Q?TUOLQaR4p91p0UayFH4im2qR1SaxXC0LxKiMHRIvCAaH9IQS4uM4EH14C8?=
 =?iso-8859-1?Q?CzGqVZk+2upfnAK8/R0HtlwlDUXAqahAtQJIZj2pSonroVvEbvK7IGOOix?=
 =?iso-8859-1?Q?PP9wb/VK0E5x/RBVLatvhoAWNZblLmXut/9ug3jBPSytNo6k9kQIdNmI2Q?=
 =?iso-8859-1?Q?JL7mY6pUHsrXPzmtnKUSvYbKVkOwb2Bt/3DPgOiWlmd2YKtrIeXINFbKGj?=
 =?iso-8859-1?Q?jHruvuJDHLXtE7qkbmRoBscFJH/Xi0nMsUoKUI7H3IOn4xwSVLJ/My65Fh?=
 =?iso-8859-1?Q?4EzHvmbCkNV/eDVEOlwD4L3U0QB3Og2cjURSL+MeXytVLsbl3bDWyzEwk/?=
 =?iso-8859-1?Q?yAlCiruNOmaOvEfrB0RHU1/43kZJLjJumbk0DnH1KrUueJa64ef7ZCoxjH?=
 =?iso-8859-1?Q?kKs6XbkGgQCy/ZmxvJFi33M0yZN12cYjmUnwEg+P75RmMvhW1JoHIsex/P?=
 =?iso-8859-1?Q?UgmJv4nLPnm2yIP1FeZzY+c76WLAzCrmz/f2O8Ui0lyJ/L/LEpx6azIwcK?=
 =?iso-8859-1?Q?+sqQp2GwH4QJVg/W939++8tFEWNiSojsf0KHX6v+ZTGsDOiiW9t/qP5Jiv?=
 =?iso-8859-1?Q?IDhuo+U3+TM4dKvCe0KGFTIFAZD2qx4GMO4AnGdctnThKlocyb2ujhCgq2?=
 =?iso-8859-1?Q?5utXqUyV01cmv/cyjmRjJBUYzftGVxbCZDKsPvzY+cEci75aWW6Ik32GgJ?=
 =?iso-8859-1?Q?e046+edIzye2FZX0WPGLj37MbSbCwx5ZyOaBwtZRmlJQfZa/AR3iqHhQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7adbad08-eff0-4e55-a1fd-08de26c46873
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 17:03:34.1008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tA5FNrsp6BSTLm0V06wAE9Mj5QpweI7Fe32qrzxbhcoAi6FXdNng/+TRabZkKQp3cZKLgcNMcNNn6F9g3uYgLQ4dPQS2wr0FXj9lRLYwKNM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10772

Hi Uwe,

Thanks for the feedback.

> -----Original Message-----
> From: Uwe Kleine-K=F6nig <ukleinek@kernel.org>
> Sent: 17 November 2025 08:00
> Subject: Re: [PATCH v4] pwm: rzg2l-gpt: Reinitialize the cache value in r=
zg2l_gpt_disable()
>=20
> Hello Biju,
>=20
> On Fri, Nov 14, 2025 at 02:56:01PM +0000, Biju wrote:
> > From: Biju Das <biju.das.jz@bp.renesas.com>
> >
> > The rzg2l_gpt_config() test the rzg2l_gpt->period_tick variable. This
> > check is not valid, if enabling of a channel happens after disabling
> > all the channels as it test against the cached value. Therefore,
> > reinitialize the variable rzg2l_gpt->period_tick to 0 in
> > rzg2l_gpt_disable(), when all the logical channels of a hardware channe=
l is disabled.
> >
> > Cc: stable@kernel.org
> > Fixes: 061f087f5d0b ("pwm: Add support for RZ/G2L GPT")
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > v3->v4:
> >  * Split the patch as separate from [1] for easy merging.
> >  * Updated commit description
> >  * Added comments about the fix in rzg2l_gpt_disable()
> > v3:
> >  * New patch
> >
> > [1]
> > https://lore.kernel.org/all/20250915163637.3572-1-biju.das.jz@bp.renes
> > as.com/#t
> > ---
> >  drivers/pwm/pwm-rzg2l-gpt.c | 11 ++++++++++-
> >  1 file changed, 10 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pwm/pwm-rzg2l-gpt.c b/drivers/pwm/pwm-rzg2l-gpt.c
> > index 360c8bf3b190..ab91bfd7da48 100644
> > --- a/drivers/pwm/pwm-rzg2l-gpt.c
> > +++ b/drivers/pwm/pwm-rzg2l-gpt.c
> > @@ -190,8 +190,17 @@ static void rzg2l_gpt_disable(struct rzg2l_gpt_chi=
p *rzg2l_gpt,
> >  	/* Stop count, Output low on GTIOCx pin when counting stops */
> >  	rzg2l_gpt->channel_enable_count[ch]--;
> >
> > -	if (!rzg2l_gpt->channel_enable_count[ch])
> > +	if (!rzg2l_gpt->channel_enable_count[ch]) {
> >  		rzg2l_gpt_modify(rzg2l_gpt, RZG2L_GTCR(ch), RZG2L_GTCR_CST, 0);
> > +		/*
> > +		 * The rzg2l_gpt_config() test the rzg2l_gpt->period_tick
> > +		 * variable. This check is not valid, if enabling of a channel
> > +		 * happens after disabling all the channels as it test against
> > +		 * the cached value. Therefore, reinitialize the variable
> > +		 * rzg2l_gpt->period_tick to 0.
> > +		 */
> > +		rzg2l_gpt->period_ticks[ch] =3D 0;
> > +	}
>=20
> I think this is wrong. rzg2l_gpt_config() has:
>=20
>         if (rzg2l_gpt->channel_request_count[ch] > 1) {
>                 if (period_ticks < rzg2l_gpt->period_ticks[ch])
>                         return -EBUSY;
>                 else
>                         period_ticks =3D rzg2l_gpt->period_ticks[ch];
>         }
>=20
> So if both PWMs of channel `ch` are requested but disabled, rzg2l_gpt->pe=
riod_ticks[ch] is 0 so you
> assign
>=20
> 	period_ticks =3D rzg2l_gpt->period_ticks[ch];
>=20
> . In that case however you don't want to change period_ticks, right?


Yes, what about adding the check that won't allow to set 0 period in this c=
ase.

if ((rzg2l_gpt->channel_request_count[ch] > 1) && rzg2l_gpt->period_ticks[c=
h])


Cheers,
Biju

