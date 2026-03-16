Return-Path: <linux-pwm+bounces-8267-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNS8N0/6t2n1XgEAu9opvQ
	(envelope-from <linux-pwm+bounces-8267-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 13:40:47 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6A6299983
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 13:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3FC6302172A
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 12:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048E939656B;
	Mon, 16 Mar 2026 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="cLn+gVRp"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75645190473;
	Mon, 16 Mar 2026 12:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773664782; cv=fail; b=Hnu/NfxXLEPbgW3qeD9bDbYUyqc5kfYFljArnPrxfX5rPKEvnVUIJh2RwMKqhx9zarAT5S7Tb6/r9JI3YGC8VTAFDYn0JHzyoI8vSjVL6pMRYYXI0vd5qv7oxjZ1bSAV+yRA7d7geecEu5mmco5Pkkei6P6fiAqP5ELc3cOV2VU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773664782; c=relaxed/simple;
	bh=sa49lNekmjtvuzNkhcALTr9UtTx2vFA5iGkzRQ9e7EM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ve8kai700MjAPDFmBPi6ZTjjrvF2d5hbYKe7k3KivEzf9OuOtAQzje4tiyetQCpIhZJ9Y4c78hfC62VX09uJvDNes9nhSqZQSbW6p1kSKF7OlCqbyRNfeWukz3UxI+G+UcT2hUesTmGT/MocaEczlfYoRUsUoUmr9odod0igv6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=cLn+gVRp; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GCXJrV1382460;
	Mon, 16 Mar 2026 08:39:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=sa49l
	NekmjtvuzNkhcALTr9UtTx2vFA5iGkzRQ9e7EM=; b=cLn+gVRpaOB46fJniGS2C
	axFvhMEJ0+G5WG+VNCfOjj6Q9po4+zDGcPsh9OFLwKze53ZJuegksDVA/EvRYdS9
	AGFmPixm9NQORehQ1tgNIyR1hnw6aFMpmC2/EOlehO1nVMdLFFeb6TRa8LXr4E4Y
	tcmacCxpGxfbjIXNYJICb8jbNy1Xt7FNwyXBLZOLDBJ9JxdVJuaRtW+hHf2ubfU5
	N6uUPTPkDSv6P9+pPtMgtkUI1AIap+b5GuO7ZdFrSEtFWQKjWyKV/wTu66wYDe+A
	cSfadyKvYRXjjomBGPaKxUumikJspeJ6zifCDJf572vO5pIzHTTu5AfmkD164sw3
	g==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012031.outbound.protection.outlook.com [52.101.53.31])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cx2d12a3w-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 08:39:23 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B8+HQ5hAzyjzZpaIxrXpwyDBK8cTb0uob2qK1vA3Y0aYpMWAedkiE18T5wwmHQpJyVRRPt+/KTtKTh6vvrq3BYkLNsq0H/UwsztgmdIIv0JaV1IasVXv2RP/ja52jO8DrqGz+6Atiq65ss3BJKYNFiek1rO4AAq1YIh1WCIm4k3zxA+5HDUaXJGmrsxqHfZAoMdzO6poKC4QB6yas/ZIs6BS1M5yWvCDBbTnzDaw9szVnd/7CW4wqkRtagGLxOCZ5zczAA8QnQQm6uARovXM3FID8BhW0AFzRI0r5osN3A2Vjpol7cVYk6zSSZzLm/Spbt7IBxuyDyx3iq52MQcw+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sa49lNekmjtvuzNkhcALTr9UtTx2vFA5iGkzRQ9e7EM=;
 b=SydVUKgJN1kM2+B7HWNlHccs8uW6w2vxg0d+MzHCItEOYx/AXey3aOY6DKXuhfYipwoLabvBxe2v/55tfTgrFHjVxWLNPS+Hwc7E8gD6vTwq+0GF0J+p9LaUi8d0MAa+fpjT2fBE371WwUdC8yrSaSWNY759NtGILi0hRLTiVe7a0nJj1dOmlFQDI/YisTUeJgkvu9O68Alqfkep4oFGfDyf62akggutljIy/0rauniie8qNnuUNDLDQtL8aZM/PkKml0yd8fkvExXdeQ9RTclDh5GHvSn863ZPhvMsbDPERgr8CshSjshZkOzH9VkYBRuuu8ZTdmiN3Exxe+gdmOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by BLAPR03MB5651.namprd03.prod.outlook.com (2603:10b6:208:29d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.25; Mon, 16 Mar
 2026 12:38:54 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 12:39:19 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: David Lechner <dlechner@baylibre.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <ukleinek@kernel.org>,
        Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Linus Walleij
	<linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Philipp Zabel
	<p.zabel@pengutronix.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: RE: [PATCH v3 1/4] dt-bindings: iio: adc: add bindings for AD4691
 family
Thread-Topic: [PATCH v3 1/4] dt-bindings: iio: adc: add bindings for AD4691
 family
Thread-Index: AQHcstE/ku+BrpeHyk25hycFu2yGm7WuKSYAgALtptA=
Date: Mon, 16 Mar 2026 12:39:19 +0000
Message-ID:
 <LV9PR03MB84149CBDC5DD03EDAF554136F740A@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
 <20260313-ad4692-multichannel-sar-adc-driver-v3-1-b4d14d81a181@analog.com>
 <a1824f39-3925-4e94-ac98-52dcdfbaa0d2@baylibre.com>
In-Reply-To: <a1824f39-3925-4e94-ac98-52dcdfbaa0d2@baylibre.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|BLAPR03MB5651:EE_
x-ms-office365-filtering-correlation-id: 4f67493b-e47a-42fd-0265-08de83590b43
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|56012099003|22082099003|921020|38070700021;
x-microsoft-antispam-message-info:
 8kEmcrTs/tN6mLfvc3CxuT78K67d4r0qmwBWejX+qRifxME9+rgJ4CU5b9k65Enk5cNyvClD2gH7eePDtptSyO8XFGvS4A6hIOPsfFOlC0UIbqBF5g1HM5fMOzgLiKFHzTYZ3IXi3GwkiLSW4zgzIFTZ3DhSd+y62GZnBJGsQslQMtvQVHj7MsjoSnoNGuw/Qta2YGVRtAXKdfxvKMqzvLv7ebuow6+fxfNm6ksCsgz7yF8/NYNksktJ63Pc8ajIOeHnvvIq7oR3J+GtuC7n7kW1WyBi1FIvlhjjt775k+FsWA1WQFLMX35VrDfexEzrt9I40B/XILNEFXy5JB3EsG2bts5XQs2uqRfYy9pgcHlU/Yddbz+T/CanX3/5xCikfdwNuI1/1hkH0h4O65hCMPIvwqCaKyDr5XTrr7AIBDzqhKbRnzjJvRYE+fAYPIysyOZQQE8ANPwqM4+8J0SnayWaGPsfK7OJKuAdWgCFI2DPLAa1RVeI8qX6/hpel04WhIeUhdhcr3gDjc82wcvcI7Su3DYqXTLALp0h7NylSS/oi3/5fOhxC//74vWQgcfHIQrw/e5LJsZ3JO306fSHbLsGK9slYFt7FnIvLMcwsqjQrQS4FPAnRT6/q99GnVc/aJu3Rpw5I1fd7zyi0aO2RDkP0B1H4TYkn5j4Y1ufP8BM4lWEwInaGomV3DZkU84AKfRmVZsjrQoIUlZ5DyEMU9UqcJP9CjBPzLOj3ioSUEc1HhIFHVdCiNwTB/5mzN6/joaMNzYzXtJBh5huEkFjd2PSusfR2NXUD2j7dQ5QIRoHTZVPtztDpARz4hJhDjjD
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MnVSTnEzVHVwN1ZwNm5WRlo2aDh4TkJuUFlMV2U2cE5yOUVyT2RsVkdMNTRj?=
 =?utf-8?B?V0pvWGg0NktyNjFEK01TYWNkWHViRjV6bUJQQTZZNnZmRjFXZWpVS2JhM0xI?=
 =?utf-8?B?dFdmWWRCRnZBUS9lb2R4cWh1bGF3UjVCbFhuZUNFKzRRd29mSVRWeFp5cDNh?=
 =?utf-8?B?R1lYWS9xU0xrOHJEN3JONDBlYk9tZUEzb29MZkRwbEl1MVpYYnp5UVk0cExO?=
 =?utf-8?B?dkZsdXhoVnFCMnh1UnZUajJQeWtHYmV0SUVadXhySHNoYVdnUlc0SXorQzlo?=
 =?utf-8?B?YW53VTEvUEhXTGtXMWM4NHhrZnB6enZ0TEF2ZW5NbzVORDg0WEkyVnhEQTlJ?=
 =?utf-8?B?Tkt1dFBZMHNPbmdGaWxBc2hoeEZQS243ZmJNdFhYeWttWnJ3dEF0RVR2a0hY?=
 =?utf-8?B?ZVJ6NnVNMHRlckxmeGx6U2thK3FlMnhDQXJGcmlOczdwZmwyVit5dmp3azBz?=
 =?utf-8?B?cFcwclZXaEFENzJjc2E0ZlA5UG9HZ1EyenJGaW9uS3dNUVEzenN0dFd6VVRS?=
 =?utf-8?B?d3RPZUlKVTRHR3dHZHdKYUVPc09kUVl1Q0xEUWZ3bkdSd0xVdWtPcG5oamZ6?=
 =?utf-8?B?cGZPNDl1YUpGUi83NUJDaTg2QUNJMThUNVplQ2U0VVhsU2pMcG5MQ295N0dP?=
 =?utf-8?B?ZnhIQjQxK0p4VVFLT3ZTSnlIOE4wSGU1c0wrajlERjdJTVMraUlRQmRaWktX?=
 =?utf-8?B?dGNYbHhVb2w5Wm1FU2gydVcrcndadWd6R2laV1dkOWdNODF5RlhVVGEyYitm?=
 =?utf-8?B?VDJLOGFDLzdLTjJmbWhFTWgvS2RJL3Y5eXlMdjJaRTlQY2IySUVzU0dUVXZ0?=
 =?utf-8?B?SVptZXV2R1F2SHpZZjE2aksxMjN1OFZkamt3ZnhQU0lWWS9PMWNFZFRUQjBN?=
 =?utf-8?B?cmF5MVE5aGlJakNCV0FZOFQ4TTQxY2N6Mm9jdFJRb09MMWJ3S0RkbGpNcmtU?=
 =?utf-8?B?bmxONjRoSVYrakpQc0pEcy9jcUEwODRHSkc1ZTdFTFlmZC83MjUrd2tYM3VX?=
 =?utf-8?B?WTNwblc2dnpjTzRiekxUeEdSNFdQRStzb3p5LzFlZDB2d2RtdTlZY2JidEw4?=
 =?utf-8?B?eEVXZE50QkFoOGNKSWZPb0RReXNJeSt0MXZ6T1BiZktBbHd5T3FmNk4vK3dk?=
 =?utf-8?B?ZGVOdHRON1NoY3dlOXA2QVdGd0dOeXhQdTBIanVtc2ZXdTh6aFNkYkgxVjA3?=
 =?utf-8?B?SG9Id2JuNTN6OG1jN1pKNVlRZHgyemJSZ0hHa0d1ZW5iK0EvYlpia3FFNTNj?=
 =?utf-8?B?TU43SEVQM0F2dUFmODl6MGNiYktiYzRlR1UzZEZ6WUMvckhQSU5SbWpMYkJL?=
 =?utf-8?B?ZVVJOURwNEh4enUveHUxNnM1ZDhEYmdWMXhZYjl3bkY4OVJCS2s1eC8wVzEv?=
 =?utf-8?B?OURYckI5MHJwNCtUQldBSjQ3ZTA3ODM0eGhabDJSVjdkYmFJNmFpbTdWQ3FF?=
 =?utf-8?B?bHBkSlZnRFFPMDRodEhFOGgwcHRaODZKZ3ZPdElod0g5OCt2MmtESXNoOWw5?=
 =?utf-8?B?SWJjYXNybi9OdGRVMlFDdVlCYXh4YnhCbWZlWjZNV1ZZRDZHdFlEY3Z5aXZ2?=
 =?utf-8?B?b3RpQ3pZbEc0OFRkTFRpUDN5am9Rb3hPNHhHd3I0M2FTdDRXaWRKU3U4STJt?=
 =?utf-8?B?SWwweTBVa3lqRWMrd2xqdnBldlA5ZE4yeXMyek5La3puSUwzbHBQSkU0SVJj?=
 =?utf-8?B?cUpjajFqRTlMRW00c0IrejRoaWF5SHBHZG1LcytZREdWOWxIdXZMVGsxQ3Ar?=
 =?utf-8?B?cEROdE1vQ3U5VUt6akZScWt1V08velZFT0FPT0hTcjdJbERJTVp0bDlSbTRx?=
 =?utf-8?B?S053bjhoTUFINUh5ZEkxbEdnVXB2K1BOZnhibnlyVnNKcUd6Vm15VFNIcHQv?=
 =?utf-8?B?Z3puQnorZkhraTNPSVV4dEw1dHNLMFNZYkY0YW9nMFNEL3F3TmZNMVkwVkM3?=
 =?utf-8?B?NGZncFZKd215UUluc2VqN0FsSEVkemp0V3R0R3luUm43WStUTEIvQys1UWNy?=
 =?utf-8?B?WXNsRmFMYzJxaEtvc2ZZRWlJY1pqWEozVUlyNFdWRnhNb0MxNG9jM29aek5N?=
 =?utf-8?B?M3I1UE4zZWE4K2QyTG1IcnhMSjNnaXpOcXRPOVFzTG5xRXFMbU1zODc3Q29u?=
 =?utf-8?B?eGl0OFVqUVdVTzR1UEFTalJMV01qTllXZ1pHRVJpdFBqNGNvZ3JWeXNDbFkx?=
 =?utf-8?B?Q0s0S0svRzl2WGZYNWRRMkVnM2J3dDVsT29EUXZwK2pDTnpJZzhMZ2RIdDVw?=
 =?utf-8?B?eGhMUEpyL0R1ZXhUUzgzYlJTSE5nSU5SQ1JYVEtHSnhjdS9FS1JkUGxvWEMw?=
 =?utf-8?B?bHVoTWkxSDd5dFlFd0pZNGZXZ09wdnRqK0dEOGV4K3ppQUlLY1Rtdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	muxFSbs9zMP53QrTBf9SL4zEyNKWmNM06ThICN8t6R+hv6TcTTvtNuBH82/PNB74CKHKJaJIzQhzozBv2exzEeG1x3sYAuy5WPBQttK5vFVoB4/b/BxXJv+hE84YsWEJcL2d4i5AgicVde+1h8v3g4HM1cDdkfi/OVjYC5anPiPhON9xpBotF/f7OwT6XiKGwSNejIhgOT1qkMz2dEw9HcOKBJjDUdS66FfEip08lIBfT4/3FAQaybhN061kKd37JUZAnJcY95KYaY8JWFWqgNR8GEIZfbMNNbmaF4DrOfIRC4IU2YGQ1hR4r25vfjm+mEjfIzVZSpgf0rF6qyy4qw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f67493b-e47a-42fd-0265-08de83590b43
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 12:39:19.7429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SNkqCjIsuWSXe/rKk25cB4Yq6cHVUDLminDurcg0qIoOOmdzNYcGW9/mFjVpb43kl+SE8opoEU+wbZ88IGXGLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5651
X-Proofpoint-GUID: cdL-c7Eb-K0r9totQ4GjSUD837V3HXhn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA5NiBTYWx0ZWRfX4G4e6TqS8iJH
 E8rM8Ek+1WCACYQ/j8L9PRaGRf926qrQC+Ix7YAt7i+EitNO+KEKWZ9+29lhKgAY5IfdbSZgUTz
 4eMsPyrV9xaG2xD7FB3w+MpuQbSdIGou5SkUk3VfK3L8VN6rahIXpOYhDEIboPyQBfICj29ybbM
 MCrtmoCw5xt5hEMVF5L1TYkvcqAewxbJ/xGOYu+/aTVY4JRHzTpz4lsEgltH1vKo9yzoEJukFzV
 vGCKsLLGK69GQ05PFGAYtwdtx7zowwuYzsDAwq+jPntlxkzg0d3CWskLvESoJ/UznBDlVNViZQa
 fxok/WtsmaLW6KcLMxQwFABF4oFT5Jww5L+aw833y2/QJNQeZKLhiUDzqb7gmFh01nBWpkwa7Km
 iEqn8zhpCBAC4InMUC2uAFpMyoKyTr8y93rBj0UdaTgMRoz7edkBjC+ABVXRfD/vr1kKNF0e8lu
 HZLmMmtrcR5V0VrsXFA==
X-Authority-Analysis: v=2.4 cv=N88k1m9B c=1 sm=1 tr=0 ts=69b7f9fb cx=c_pps
 a=yf4wneJBeBA4fm5+j3KMTA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ZQxX5BWu6Z8IJBb2zLX7:22 a=IpJZQVW2AAAA:8 a=RSHEMkk9tVl3yX_U8EoA:9
 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: cdL-c7Eb-K0r9totQ4GjSUD837V3HXhn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160096
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-8267-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[baylibre.com,metafoo.de,analog.com,kernel.org,gmail.com,pengutronix.de];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:email,LV9PR03MB8414.namprd03.prod.outlook.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,analog.com:dkim];
	DKIM_TRACE(0.00)[analog.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Radu.Sabau@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8A6A6299983
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgTGVjaG5lciA8
ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiBTZW50OiBTYXR1cmRheSwgTWFyY2ggMTQsIDIwMjYg
NTozMCBQTQ0KPiBPbiAzLzEzLzI2IDU6MDcgQU0sIFJhZHUgU2FiYXUgdmlhIEI0IFJlbGF5IHdy
b3RlOg0KDQouLi4NCg0KPiA+ICsNCj4gPiArICBjbG9ja3M6DQo+ID4gKyAgICBkZXNjcmlwdGlv
bjogUmVmZXJlbmNlIGNsb2NrIGZvciBQV00gdGltaW5nIGluIENOViBDbG9jayBNb2RlLg0KPiA+
ICsgICAgbWF4SXRlbXM6IDENCj4gDQo+IEkgZmVlbCBsaWtlIEkgYXNrZWQgdGhpcyBhbHJlYWR5
LCBidXQgd2hpY2ggcGluIGlzIHRoaXMgY2xvY2sgY29ubmVjdGVkIHRvPw0KPiBJdCBzb3VuZHMg
bGlrZSBpdCBpcyB0aGUgY2xvY2sgZm9yIHRoZSBQV00sIG5vdCB0aGUgQURDLiBTbyBpdCBkb2Vz
IG5vdCBiZWxvbmcNCj4gaGVyZS4NCj4gDQoNClRoZSBwaW4gaXMgY29ubmVjdGVkIHRvIHRoZSBD
TlYgcGluIG9mIHRoZSBBREMsIHdoaWNoIGluIENOViBDbG9jayBNb2RlDQpyZXBsYWNlcyB0aGUg
aW50ZXJuYWwgb3NjaWxsYXRvci4gDQoNCj4gPiArDQo+ID4gKyAgcHdtczoNCj4gPiArICAgIGRl
c2NyaXB0aW9uOg0KPiA+ICsgICAgICBQV00gY29ubmVjdGVkIHRvIHRoZSBDTlYgcGluLiBXaGVu
IHByZXNlbnQsIHNlbGVjdHMgQ05WIENsb2NrIE1vZGUNCg0KLi4uDQoNCj4gPiArICAgICAgVHdv
IGNlbGxzIGFyZSByZXF1aXJlZDoNCj4gPiArICAgICAgICAtIEZpcnN0IGNlbGw6IFRyaWdnZXIg
ZXZlbnQgdHlwZSAoMCA9IEJVU1ksIDEgPSBEQVRBX1JFQURZKQ0KPiANCj4gSSdtIHdvbmRlcmlu
ZyBpZiB3ZSByZWFsbHkgbmVlZCB0byBzcGVjaWZ5IHRoZSBldmVudCB0eXBlLiBGb3IgaW50ZXJy
dXB0cywNCj4gd2Ugd2UganVzdCBzcGVjaWZ5IHRoZSBwaW4gYW5kIG5vdCB0aGUgZnVuY3Rpb24g
d2hlbiB0aGUgcGluIGhhcyBtb3JlIHRoYW4NCj4gb25lIHBvc3NpYmxlIGZ1bmN0aW9uLg0KPiAN
Cj4gSSBrbm93IHRoYXQgd2UgaGF2ZSBkb25lIHNvbWV0aGluZyBsaWtlIHRoaXMgb24gc29tZSBv
ZiB0aGUgcHJldmlvdXMgU1BJDQo+IG9mZmxvYWQgZGV2aWNlcy4gU28gbWF5YmUgdGhlcmUgd2Fz
IGEgZ29vZCByZWFzb24gZm9yIGl0LiBPciBtYXliZSBJIGp1c3QNCj4gaGFkIHR1bm5lbCB2aXNp
b24gYXQgdGhlIHRpbWUuDQo+IA0KPiBJIHN1Z2dlc3Qgd2UgdHJ5IGltcGxlbWVudGluZyB0aGlz
IHdpdGgganVzdCBvbmUgY2VsbCB0aGF0IHNwZWNpZmllcyB0aGUNCj4gcGh5c2ljYWwgcGluLiBJ
biB0aGUgZHJpdmVyLCB3aGVuIFNQSV9PRkZMT0FEX1RSSUdHRVJfREFUQV9SRUFEWSBpcw0KPiBy
ZXF1ZXN0ZWQgaW4gdGhlIGRyaXZlciwgd2UgY2FuIHVzZSB0aGF0IHRvIHByb2dyYW0gdGhlIGZ1
bmN0aW9uIG9mIHRoZQ0KPiBwaW4gYWNjb3JkaW5nbHkuDQoNCkkgYWdyZWUgd2l0aCB0aGlzLCBz
aW5jZSBvbmx5IERBVEFfUkVBRFkgd2lsbCBiZSB1c2VkIGFueXdheSBhcyBhbiBpbnRlcnJ1cHQN
CmluIENOVl9DTE9DSyBtb2RlLg0KSW4gZmFjdCwgSSBhbSBub3cgdGhpbmtpbmcgb2YgcmVtb3Zp
bmcgQURDX0JVU1kgZW50aXJlbHksIHNpbmNlIGl0cyB1c2VkIGluDQpqdXN0IHR3byBjYXNlcywg
d2hpY2ggbm9uZSBvZiB0aGVtIHBlcmhhcHMgbWFrZSBzZW5zZSA6DQoNCjEuIE1hbnVhbCBNb2Rl
LHdoZXJlIEFEQ19CVVNZIGlzIHNlbGVjdGVkIGZvciBHUHgsIHRob3VnaCBpcyBub3QgdXNlZCBh
cw0KYW4gaW50ZXJydXB0IG9yICdmZWVkYmFjaycgb2YgYW55d2F5Lg0KMi4gQXV0b25vbW91cyBN
b2RlLCB3aGVyZSBpbiB0aGVvcnkgaXQgd291bGQgYmUgdXNlZCB0byBzZWUgd2hlbiBlYWNoDQpj
aGFubmVsIHdhcyBzYW1wbGVkLCBidXQgdGhpcyBtb2RlIGlzIHVzZWQgZm9yIGp1c3Qgb25jZSBj
aGFubmVsIHNpbmdsZQ0Kc2hvdCByZWFkaW5nLCBzbyBhZ2Fpbiwgbm90IGFjdHVhbGx5IHVzZWQu
DQoNClRoZSBpbXBsZW1lbnRhdGlvbiB3b3VsZCBzZWUgdGhlIGVudW0gcmVtb3ZlZCBhbmQganVz
dCBpbml0aWFsaXppbmcNCnRoZSBHUHggcGluIHVzZWQgYXMgREFUQSBSRUFEWSB1c2luZyBhIG1h
Y3JvLiANCg0KV2hhdCBhcmUgeW91ciB0aG91Z2h0cyBvbiB0aGlzPw0KDQo+IA0KPiA+ICsgICAg
ICAgIC0gU2Vjb25kIGNlbGw6IEdQSU8gcGluIG51bWJlciAob25seSAwID0gR1AwIGlzIHN1cHBv
cnRlZCkNCj4gDQo+IElmIEdQMCBpcyB0aGUgb25seSBwb3NzaWJsZSBwaW4gZm9yIGFuIG91dHB1
dCwgd2Ugc2hvdWxkIG9taXQgdGhlIGNlbGwuIElmDQo+IHRoZXJlIGFyZSBtb3JlIHBvc3NpYmxl
IHBpbnMsIHdlIHNob3VsZCBkb2N1bWVudCB0aGVtIChldmVuIGlmIHRoZSBkcml2ZXINCj4gZG9l
c24ndCBzdXBwb3J0IGl0KS4NCg0KWW91IGFyZSBhbHNvIHJpZ2h0IGFib3V0IHRoaXMsIG90aGVy
IHBpbnMgY2FuIGJlIHVzZWQgYXMgREFUQV9SRUFEWSwgYW5kIHNvDQp0aGUgRFQgc2hvdWxkIHBl
cmhhcHMgaW5kaWNhdGUgd2hpY2ggb2YgdGhvc2UgcGlucyBpcyBhY3R1YWxseSB1c2VkLCBzbw0K
dGhhdCB3ZSBrbm93IGF0IHByb2JlIChncGlvX3NldHVwIHdvdWxkIG1ha2UgYSBjb21lYmFjaz8p
IHdoaWNoDQp2YWx1ZSBzaG91bGQgYmUgd3JpdHRlbiB0byB0aGUgR1BJTyByZWdpc3RlcnMuDQoN
Cj4gDQo+ID4gKw0KPiA+ICsgICAgICBNYWNyb3MgYXJlIGF2YWlsYWJsZSBpbiBkdC1iaW5kaW5n
cy9paW8vYWRjL2FkaSxhZDQ2OTEuaDoNCj4gPiArICAgICAgICBBRDQ2OTFfVFJJR0dFUl9FVkVO
VF9CVVNZLA0KDQouLi4NCg0KPiA+ICsNCj4gPiArICAgICAgICAgICAgY2xvY2tzID0gPCZyZWZf
Y2xrPjsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgIHB3bXMgPSA8JnB3bV9nZW4gMCAwPjsNCj4g
PiArICAgICAgICAgICAgcHdtLW5hbWVzID0gImNudiI7DQo+IA0KPiBTaG91bGQgd2UgYWxzbyBp
bmNsdWRlIHRoZSB0cmlnZ2VyIGluIHRoaXMgZXhhbXBsZT8NCj4gDQoNCkluIHRoaXMgZXhhbXBs
ZSwgSSB3b3VsZCBzYXkgdGhpcyBpcyBuZWVkZWQgc2luY2UgdGhlIENOViBQV00gaXMNCm5vdCBv
bmx5IHN0YXJ0aW5nIHRoZSBjb252ZXJzaW9uIG9uIHRoZSBBREMsIGJ1dCBhbHNvIGNvbnRyb2xs
aW5nDQp0aGUgc2FtcGxpbmcgcmF0ZSwgbWFraW5nIGN1c3RvbSBzYW1wbGluZyByYXRlcyBhdmFp
bGFibGUgaW4NCmNvbXBhcmlzb24gdG8gdGhlIGludGVybmFsIG9zY2lsbGF0b3IgdXNlZCBieSBB
VVRPTk9NT1VTLg0KDQo+ID4gKw0KPiA+ICsgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPDEyIDQ+
Ow0KDQpCZXN0IFJlZ2FyZHMsDQpSYWR1DQo=

