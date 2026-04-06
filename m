Return-Path: <linux-pwm+bounces-8492-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNU0LIPA02kalgcAu9opvQ
	(envelope-from <linux-pwm+bounces-8492-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 16:17:39 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5F03A3D88
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 16:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE00A301386B
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Apr 2026 14:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D03637F8B3;
	Mon,  6 Apr 2026 14:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="jd/f0arH"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0313D37F72D;
	Mon,  6 Apr 2026 14:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775485053; cv=fail; b=Tf7+fwX40GDU5nCDlBXFibF6f0l2iocil5DCB7bz4WxGwenKwVGoQ1dGXGoZA9fes3kF5fGAQdi0GMc/R3cpFB/uuFLr4xBoCAlwc5FKhmw+appKETxln+StalVIXawjXhQWPC97vhk+KYm5KgaqFOetpPhWpfKBLP6M/lMWeEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775485053; c=relaxed/simple;
	bh=3RrIIhv9rax0CVSw1HNNjsZyoilJWVkhGDJPgfVUxaw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IaRPyHtYlY/84pEHhwzUBmhj9LIa97meJvUaxGbcX4L68VdLl7evLrHaurmaJPTDwBMAKYWiMg6wjDrjOzy74XJZBSJb94jsVFoA6z521XNyBQSUeveGQhJImBlM9xLCGTIb7MA6am33F9BSxBAxSY23xpOifzr57YQbOIh1uLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=jd/f0arH; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636DcvZT2808507;
	Mon, 6 Apr 2026 10:17:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=3RrII
	hv9rax0CVSw1HNNjsZyoilJWVkhGDJPgfVUxaw=; b=jd/f0arHwiG+nJczO5+Km
	rEP7GUgFG5+Z2dPRu3/obLgi0whDn+5EGBmhAAkEYBQ3lqAh46FAvOpog+1M9I6n
	lAk71gI85B7qI4I/IvwI6pUCn8nLhqMgO1lkYMfXe9HzTRdYG3rYHQPn4lGLQ6nE
	XqOzd/8+7ghzhZKEo+ZSkMoj4mIfHkUDB9XLNdYmqE8B/yhg4LgVv8dPx5zxCVfJ
	vf7t2loNrcBOLUx1mQl09EBUyY9TyQsnITvIf4OB9yyOE7q2vfDRDPaAppfD2ByJ
	H1lmhCJSazMYICceUdIUCa5docjId6BSacG/kN2BMm/v6nUijdhevwrKYBs++EWF
	g==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011057.outbound.protection.outlook.com [40.107.208.57])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4davd78kgc-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 10:17:11 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jr739UZvTJuLfdN5eCgiNbWNibUnL6RLXIV/m6Sj/SXU5nptbf32N6ZMZc/qQRdmDhZ24xqimFEXnLTLsAwsExJFczJkeJicYT/cb5Bd/lBhJv2/gQMWKdApAxjJOmPNYJ0Fr+oPY0U3fx+6MmR9Z/D8tk3n+0YL5HcBoJaDW278XtiWIao3xH8tf9nNQBs8RJnFQ9g8Eoj7MvizW96GcCAgVlH6MhIejAQ1crU3G4qP0GbFBdwV4Bkmvut+tOEti9GUhITUV2pX7EiDrl0Xixvp87MIibV03oC8LNIHhmaAf9GD3f96Erx1D8koLRMKWVIk6fpRMyBi56W6RT/5eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3RrIIhv9rax0CVSw1HNNjsZyoilJWVkhGDJPgfVUxaw=;
 b=mG2VRz0aBcV6vV1LjIvcWYpfEKZwyNHsQHsMfhZ0CUyPzZzf8yng5I3DwaeqQsq5k5XtFU2ABb3VettbTAu0wZExl/ZVlzxQBvUSDSYcHra9Qy+gODHJZGnYWDfzaq2zZtULt7vMmKpI9vWE4P8qZ3UEYmGxOUESyDqQKv5r3DN+w4LpmHwgsAKdYUBxuscJYrxtQL+bLlqtEL1lkSpdHkN5cSjDKVpY2d9pWTtFneX3Lk7TQgWo3+YpLmgKSxfPgmCKW9aqtV7oBmQvIwex5QCXjVlp07BD3+W9oH15YPbnrGzAolYha/vEpj2m2XawOzVZNvQU7atxlVEC4zOetQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by LV4PR03MB8356.namprd03.prod.outlook.com (2603:10b6:408:2de::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Mon, 6 Apr
 2026 14:16:59 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 14:16:59 +0000
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
	<p.zabel@pengutronix.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan
	<skhan@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v6 4/4] iio: adc: ad4691: add SPI offload support
Thread-Topic: [PATCH v6 4/4] iio: adc: ad4691: add SPI offload support
Thread-Index: AQHcw1l5C7eBe1gr9kKzzEquafv7BrXPClqAgAK8tzCAAEkagIAACJWg
Date: Mon, 6 Apr 2026 14:16:59 +0000
Message-ID:
 <LV9PR03MB8414CB15DEC3EBBDB8F5FDD0F75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260403-ad4692-multichannel-sar-adc-driver-v6-0-fa2a01a57c4e@analog.com>
 <20260403-ad4692-multichannel-sar-adc-driver-v6-4-fa2a01a57c4e@analog.com>
 <1d0d41c8-7867-4459-a91a-a2c6774b1885@baylibre.com>
 <LV9PR03MB84145906CC191F6AB8D2D3DAF75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
 <420dba4a-0c31-47bc-b84a-5d29702b115e@baylibre.com>
In-Reply-To: <420dba4a-0c31-47bc-b84a-5d29702b115e@baylibre.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|LV4PR03MB8356:EE_
x-ms-office365-filtering-correlation-id: 4e515621-efa6-4ac2-2405-08de93e72ab4
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|7416014|921020|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 UAH20o5wDv0B05gym1Fd7xwPp4U34KQYdKP/cpdl1iSl8ooIprlC7WORPyMTPIwTyHvRUwphGvPI6IB0GZ0IWbSp5TDIYXVSX5jClA46RIzatpbpokfN//jsDYKy2JburHI1vS/JDj9E42C9QlWDXSbNQy0ZZu112wS2bbVH49nM8cE1K9gzchYxuVeeXURztY+q/hE5OsE4ilbh/jjDbeJgXyp7sSsqC7geck2KOIR2duo2xDx8rDjDzjyUcACqVzkETaMTJffEycge87vA/NSDFDEejvs9XVKC3kpNFFS8EsN6WkBhiGkt9IamoxfnhC4S6V/s26NknryYkHIwwvwN0kEm9n2d0loLb3GQDnmpN52iXQUFRjSIXIhOgsKsB8jZhX6MlPB7kwB/4X+uNZV1tDukz+fcbep4roaCUCk0vUN0cDMyKVWxAMv6qC8Dd0fIZGZAQxK6CBC/b8kNqVWfpLg9VddagoG/QjobmPqL4BzJjSLct2E8fa+G1ZZgLbCJc8qfA3NlsmngBbLV+x5cFbGza0dhtR2/Z7pDubz28dQYd0NDOf0VvZF8ocXb75oQbyWHq5a1aRHIIQ/7k0SuwTMJTHzjOEOhXcoPU3DQRu63LM8fD/DtRHSWPo72ay2h0LRAKUthAx1MI4QqVs0eq4BPvt+u6x7oYd3SkW0R35YJUUNo+Eq7zz5AsgCIik58E4egCy1KpjBba73mqELfZxOglYRrRFnExFsODBupVJkWRkX1ykyDkoGav+m+oC2P/J7Y/iPlt01WUm5Cw4o96/ezBiZJ1yLgNghGAdA+iVIYE51lnOcSCr8FEziF
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(921020)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZUx3aFpiQjQ0MkJreDh5bDlNaFljU09jNCs0dTRwU1NhS2pxUzl4ZGZ5eHBK?=
 =?utf-8?B?ZHloay9idlpDT3dnSFRYVjY4NldqNk1OeDlOcE5ocFlXMEtHd1lSMnZFM1pK?=
 =?utf-8?B?bWdDL3RLQ2lpR3h5MTk5Rm9POURXUHlUaXU0bU50OVFZNFppWUtVYkQ4ODJG?=
 =?utf-8?B?Q0xHeEJQWHRxWVZPNklaYzhqa2I2REUvOHkwcVY3ZHRLczQ0ZzVBZXFRc1Ay?=
 =?utf-8?B?bndPd24rUm92MFJObHhNeTMxcEpjSFJsdGVlTXRNaGVvRCtuemM0dU92eFlI?=
 =?utf-8?B?SXpUdXJxa1lYdlFKMHgwb2IrRmZnWjY5Ry9haUJLdStzcWhJTGYwNWVpL1NS?=
 =?utf-8?B?QjRZYXpBS29EejdBNDd6Q2Fsc1RMWW1pS1hKTTBWQjRMMWcyZkZvR04zZC9R?=
 =?utf-8?B?MGNzTEh2Q3Z1ZkV3VU1UQW5OcjJFR3FqTTQ3QVFlN25ZVnlaRGNCcWNOb3pz?=
 =?utf-8?B?K21iaHhHcDJiNTdNbm1IYTFNVHYyUXIyaHpCUWh4ejVneHQ1OCthcHp1d0tK?=
 =?utf-8?B?NktRby8zcHJUYkI3cHpZL0Z5c3VDUVJQM0ZXVFBKNUptNWNhUFhRMlBpdUVz?=
 =?utf-8?B?NWZHb2VlUXZOaGc2RWZRMHNIRjNDUTBWNEh6TVJHeWFCaUdVUUN1L0drMDRD?=
 =?utf-8?B?VENrUE05dEZWdGtIY29DSzIzNWZZcXFZK1oyb0ViK2premI2SjBlSW9YL2xr?=
 =?utf-8?B?MDBiVWZBMnN1dXNsYjBCazJ1cGpjb0w0YXcydVo3ay9xRGpualFTelhmUnB4?=
 =?utf-8?B?UUd4YTkvaWh1U3hUTWNZRUdBKzV3Y3UxODlVUzI2ZGRzT3U1YVlsMWdqOWph?=
 =?utf-8?B?OVh3WG10ZDlGSmVyZ0VhNWkxTVp4Y21zUGhLLzRRc3YxVDA1cHpwVHNCdFRZ?=
 =?utf-8?B?Wks5QkdBNHc1TTNBM2d5bEZqV29MdUNOYzJXLzdmMG9jdEhxUGxya3dDZ2U2?=
 =?utf-8?B?ZmhtT3ZnZG5Od3liVmpGaFV3cDFEeFo0S1ZIREVyS0d6RXk4WjJQeWZWME4y?=
 =?utf-8?B?UUFxSDNOYzFBZ0Y0OUVxL0N6Um9DSzArbFJHdzllSXB5akhNMDVVM2FkR0J0?=
 =?utf-8?B?cU02dEQ3amd2Skw2U3YyWjB3c09FTkQ5UU4zSVVmb016MGVxWHY3dmVFQSs1?=
 =?utf-8?B?SXVueGswRDRSNFpzQjFFTGtOZkYyVXpJdkM4MGZJVkhkWHd1VmJDc3dvSVhF?=
 =?utf-8?B?Wi91WFNaVmZtcmNvWlUyWGxLVE5KdCtaaVFGYXYyUjltVHltRlRZUlpXNjVG?=
 =?utf-8?B?aUFCN3BUK3BUVkdUelZyUitNalZxa3phRlU3cHF4OXdLRFNlNitVRjZrLzhJ?=
 =?utf-8?B?MlVpc1BpcldzckVJMjIxcG1nbDVnWG4vQ3hIbmFWL2hBd0U1ckxkS3ErSDUz?=
 =?utf-8?B?MkwyY2pTbmIvclIwQlNQbTh2bDRUNnpEczJQOUlwK29aL1FOU2k0VURnQkxj?=
 =?utf-8?B?d3Ayb2F5TENXcWJWMGFWcFdGaXV1T0l6VE55SXFGYkw1blkxQzRMYy9IeXZn?=
 =?utf-8?B?aDY3ZENkUWU0UnlhWk9sUUpyd1dZRnl5bVJJbldRY3VNQTVEZ2l1UnNmc0FV?=
 =?utf-8?B?VGtUOFZpMWdGMDRESnRxK1pPMFZ4Qm9KaE5oYWR4NFFvT0ZFTWNTTjVVMkJ4?=
 =?utf-8?B?VUJxTTZnMGh3RXhlVGk0dDNFYnoxK0hoc05tT0JWRk95N0c1M1d0TXRCR2lE?=
 =?utf-8?B?ZUhjRk1oZC9pUXpnZU1PWjcvb0FZV1djbnZZbEFzaFNEaktBYXRsZVNKeVEv?=
 =?utf-8?B?LzBxRExubC9XeHRxWE44Z0h1QVE2MUdmOUt4NHJRYlNnSDV2Snl5UEl2bUdZ?=
 =?utf-8?B?eG54SEo2cldiS1VVZm9jVU55SzQ5TktIVlJLMWdPcTMyMDVRSERqeHI3elNa?=
 =?utf-8?B?SFhLMGJram9kYVVpenBWR0NiQjhoWEJnSDd1eDlEWnVNNWR2S2NIVTJNcElE?=
 =?utf-8?B?S3p1UlBsSy95L0VGYXlOUmJNY0Nic3QxKzRheUVocG5JdnM3Wm9VczFod08r?=
 =?utf-8?B?ZlZ0Y3k2aEl5NldsaGtxUDFnUmorUC9hMDdQVXl0Ym9lditzTXBpbE5IQnpB?=
 =?utf-8?B?TDh0YUpCU0NLdExYMzV3QWp6OHR2aFp6dm1CcTg3ZmdjTHRESzQyTnJheEk5?=
 =?utf-8?B?NldtN2lFbVZMOS9XeWQ0Q2Y5anErbmpOditsc2REODBTa0NQRStlbjI4M0Z1?=
 =?utf-8?B?SGxYcUV0WkNyNHV4TWRqVE1HSVNCQXRjQ0F4ME9xYTAwV0c2d0FocUEwQjgy?=
 =?utf-8?B?cWQ5OWdzamVkSktQTFlnaFpidnJFbDNtWitaaFB6Q0xMdkhJTmwzMVpaaE1S?=
 =?utf-8?B?MFMvelJoOXh5bjg1N01Gb1o5NjR4bFNQMDN4SVRRK0pyVGxEb2lCUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	YfCVTPRfE9iwmz2WWfbTXavphNcuBbpnxMzTuFNeE6uuhvgJJyR0dp7wAI0IOzvbl7d2I+GmxGXjoL5F4adaqAUjIv7gTwDCvewM5FYf5pSQrVz2sZI9/48T++JopZwun0tBS3FIZWL7xCVX3p1inIATDSeKqlY9Z77zbjrvtT4OXau5fgoTbX5qo/mNYWqZJXyuEeQCgWslI1acrIF+0kJVXZjqKvNJH9OtTRleIFccjNBXUJesm+gPIoVfZFFO2uQE4BYB/XP1TziMR+Jv5D6EO7LInAZHh+LoCrVzS5QofxFFHbtrvmvBxbVO74M1J77iFyv/5UJ9SZJYWSufuQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e515621-efa6-4ac2-2405-08de93e72ab4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2026 14:16:59.5806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: udrNcgFL8EE8r0ToYWEau/Nc92nHBYgkxnRcRZHu90/2T9XInuf4ku3AlhzdpgmSGg9Lc5A5I6ZvnQIhwUnL7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR03MB8356
X-Proofpoint-GUID: GlducibFuGznj-g-9XjdNfXJSqXxdZBX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDE0MSBTYWx0ZWRfX3hfU3G80j5eH
 3JL7VupdpG5mw2HK0UBz5Mkt8ddnth4vXmLTETvKCTSWml/nrKf98R968IilIzRddds/fZWZaf4
 amE/lssTb0HXQ7UF6tjj+rjmf7bQI3qDTUvjIhD4UeolV/cfNbbPKihZUVOOpCyBTDjhAXCpk+d
 TrG6+BJwaaMqSVpJSfqaV3vd4FYel+r4p42UYQvp88Mn58JRzkXJ+X6eBg79Tau1HMNRKFnE3yn
 zFYUgn//ayADhDlc1zl+LKXro9ydNmAT1i2q+Zp2ENmIAzY8QDI678UNJcBTyjxBG/4Jn1bO8NQ
 VFiiJD5wQ5vLzWkq30aRC52LYfvuhP6d+4mjlomJxHNyz1G+9Po4VpThVv6QWTfy6UvxVXxWeuw
 vLXKjjQmPVFj0LdCM2sjMo+D3eKHyv0zOum/B0kbEYPiRXEImvc4X4Nc8PQDOGV7Ae0gNQ+KeaK
 oP4VXBdBmskOEH5DHOQ==
X-Authority-Analysis: v=2.4 cv=bulBxUai c=1 sm=1 tr=0 ts=69d3c067 cx=c_pps
 a=VQepQl8SEyt8JAUUu+gXkg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ugNRTJOwpmtT476g4l8T:22 a=IpJZQVW2AAAA:8 a=u8FSRKIWE1w3BvPM3dEA:9
 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: GlducibFuGznj-g-9XjdNfXJSqXxdZBX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060141
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-8492-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[baylibre.com,metafoo.de,analog.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,analog.com:dkim,baylibre.com:email,LV9PR03MB8414.namprd03.prod.outlook.com:mid];
	DKIM_TRACE(0.00)[analog.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Radu.Sabau@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-0.983];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4F5F03A3D88
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGF2aWQgTGVjaG5lciA8
ZGxlY2huZXJAYmF5bGlicmUuY29tPg0KPiBTZW50OiBNb25kYXksIEFwcmlsIDYsIDIwMjYgNDo0
NCBQTQ0KDQouLi4NCg0KPiA+DQo+ID4gVGhpcyBpcyBiYWQgZG9jdW1lbnRhdGlvbiBvbiBteSBw
YXJ0LiAiY2hhbm5lbCBieXRlIiBpc24ndCB1c2VkIGFueW1vcmUsDQo+ID4gdGhpcyBpcyBwcmV2
aW91cyB2ZXJzaW9uIGJlaGF2aW91ci4gUmlnaHQgbm93LCBvbmx5IDE2LWJpdHMgd29ydGggb2Yg
YWN0dWFsDQo+ID4gY2hhbm5lbCBkYXRhIGFyZSB1c2VkLg0KPiA+DQo+IFRoZW4gd2h5IGRvIHdl
IG5lZWQgdGhlIHNoaWZ0IGlmIHRoZXJlIGlzIG5vIG90aGVyIGRhdGE/IENhbid0IHdlIHJld29y
aw0KPiB0aGUgU1BJIG1lc3NhZ2Ugc28gdGhhdCB0aGVyZSBpcyBubyBzaGlmdD8NCg0KSSB0aG91
Z2h0IHRoZSBzaGlmdCBpcyBuZWVkZWQgc2luY2UgRE1BIHNpemUgaXMgMzIgYml0cywgYW5kIHZh
bHVlIGNvbWVzIG9uIHRoZQ0KdXBwZXIgd29yZCAxNiBiaXRzLCBub3Qgb24gdGhlIGxvd2VyIG9u
ZXMgYXMgZm9yIENOViBCdXJzdC4NCg0KTWFudWFsIE1vZGUgbGF5b3V0OiBUWCBbQ01EX0hJIENN
RF9MTyBEVU1NWSBEVU1NWV0sIFJYIFtEQVRBX0hJIERBVEFfTE8gRFVNTVkgRFVNTVldDQpDTlYg
QnVyc3QgbGF5b3V0OiBUWCBbUkVHX0hJIFJFR19MTyBEVU1NWSBEVU1NWV0sIFJYIFtEVU1NWSBE
VU1NWSBEQVRBX0hJIERBVEFfTE9dDQo=

