Return-Path: <linux-pwm+bounces-8487-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULgsNK6102nLkgcAu9opvQ
	(envelope-from <linux-pwm+bounces-8487-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 15:31:26 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE053A390F
	for <lists+linux-pwm@lfdr.de>; Mon, 06 Apr 2026 15:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A12A63013A44
	for <lists+linux-pwm@lfdr.de>; Mon,  6 Apr 2026 13:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA032D879E;
	Mon,  6 Apr 2026 13:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="PtMEpAhG"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEEC22D792;
	Mon,  6 Apr 2026 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775482246; cv=fail; b=p7oGK3gpUmB6HyU+xwrpmiGnYZ/IBognnRx9n/cSMY3foyRxBSfaRjL5D0Bi6VMytpDaliiFFj4op7QhwidXl7eyh6b9BqnWgROgKW7o3bgM6u3599ptiNP1TpwbXzhxfwPK+8+ZSztbvMMx8xd9ai09fNgiDeEVYh6Ogu6Yogo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775482246; c=relaxed/simple;
	bh=IDHBAsflHxfXSSibhaGiqIVElEp2MmEniZ4xoxolg4I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g2R72PCsy/2bHPeYojdSUpiZWQN0OpIwT6gH4ePZ58pgLAYx7z4NiF4cCxj1D9hIBaZbm+Qg8KO49rpu+49Auxa/i9WBUu4lqcsBC7nxvd5UsThY71jzqOq1rXhIZNq88W+/bRoVid0drgPdPHk2gg2OYxtP7HZm/8mXeFiKwCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=PtMEpAhG; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636CmKER286126;
	Mon, 6 Apr 2026 09:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=IDHBA
	sflHxfXSSibhaGiqIVElEp2MmEniZ4xoxolg4I=; b=PtMEpAhGEfvQs3DQo3pBX
	hccTAcvhgWlsfKE6lZoR+o1S2j3/4vbI7OivRBajJPk8qHyVHbsiXKJA1FxhnuEC
	OWKPg9yT/HddBM0sDkviuw7xegM2/PIZlEee3Mvwe+uIOZ2ewiCKwpF25K85APRi
	1dAgewlY5fuaElWSauf6U6m0rdefCksxGMh7BGfLFolczfI6U0dXsbQhIjmAC6ZW
	lALaCB6A45udkIH5WQvfBpA4RJFMnnrRxcPn4Q3n/pxe1GSHkJ/vhFQFc5TI2Hwo
	p+/zaTvGCWOJXYhocEoDBjOtGGXHPD+rdg2bIdHd0/uNPKmak1mwjUeLI4vR+1ZP
	w==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012039.outbound.protection.outlook.com [52.101.48.39])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4day93yyqm-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 09:30:23 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ip7Skt0HqE9H/SLxt+rayx70bse7elhvTBlckj2Wsw4B1S9j0fhqD3zfLWsqwt9kyDvZp2NeI2yReJ/63WgNZw8YzhDD5dN+085rcb6MtoVpe7BJk7wZuNyHQj46PHIy2KUPlzU3OZyt9PH+0AOU4JljyNhsxrYTjwMMGiZOqXKzSl3MVVnakJVa7X6oSq3YuvchSdgaM2ussQGPivJYErUcA0ojKrGptrA4fDnUQlW6/50xqvT7ZehTPBjfAh/UW41CFZbB4zof31P1z1XbqkL6D/2ZNQ5P+iqIp4wA2cMN2rbb9arkuonvY1BG9OX0K9g94koUJwWTecHtR1Cp9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IDHBAsflHxfXSSibhaGiqIVElEp2MmEniZ4xoxolg4I=;
 b=Tm3tTPc2dqo8yAo6qwKfXit31hWUYw6K3doculymzuCswjAvQg1soS3U+CZzkCdWTiY8/m9CXfP2fQbKEZjNBUVkHHIkQYao7zcJw4gQDckczI9UXVcdgh9KNZrcUV6SqEq3LUV/lvZ0dNDwKcxUWc0yA8+63nw93m/XTaGdm3+0xbRcPc8AKXkcEJw/tCJL0pxhjy3ueDIcaNr6n68OiQ25DZbXtcJb+TdJ2rzu3anHqy8fCnNtgUZK3VimLL3ZcqbYXOPScyopl8bNXv3FI8a8eWQp3E1n+HitL7mUsTDln62z1M8d1G7ay5N/Qax/bLGP4aDzjwtbPIKvUy7QnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by SJ0PR03MB7022.namprd03.prod.outlook.com (2603:10b6:a03:430::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Mon, 6 Apr
 2026 13:30:17 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 13:30:17 +0000
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
Thread-Index: AQHcw1l5C7eBe1gr9kKzzEquafv7BrXPELuAgAK5+HCAABcC4IAAIQJA
Date: Mon, 6 Apr 2026 13:30:17 +0000
Message-ID:
 <LV9PR03MB8414BB41577A8B5A0432463FF75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260403-ad4692-multichannel-sar-adc-driver-v6-0-fa2a01a57c4e@analog.com>
 <20260403-ad4692-multichannel-sar-adc-driver-v6-4-fa2a01a57c4e@analog.com>
 <22b44acb-bfb5-4b97-8fa2-aeb4aec704c2@baylibre.com>
 <LV9PR03MB8414CB6B07EA81FB5A42436AF75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
 <LV9PR03MB8414C570998C4C1EE59ABFBBF75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
In-Reply-To:
 <LV9PR03MB8414C570998C4C1EE59ABFBBF75DA@LV9PR03MB8414.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|SJ0PR03MB7022:EE_
x-ms-office365-filtering-correlation-id: 168bbebe-8313-4fcf-9505-08de93e0a463
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|18002099003|56012099003|921020|38070700021;
x-microsoft-antispam-message-info:
 WlnllCbG2c5AMpwFSZPEGYf0JexpqlnZVe+HQrVr49gmXDrZ3RilKrxJwStShI6VIdXI002sxtAOhsmhJpLSoB5YTP34vQl/KoJ7s9oGLl8c6MH3J31W6S/b32s5rjkzMs/22GAIKMiT4tN+ojL7PW4jRWqZCBIWFPmV4rAWwS9xFlou9Q6wATYMHjO9HcTM3X5kL0D9yZOFMJnXZCApMHv7oTHaKDlAuHx6mC4uFWZFR4AZnuleyRrmzbD0zD5aE4gKdBb/jJ4PwAizTTrfv8J+jzWCWtAhMYnv9POXFAqSVxFcY2iBiOl7KwiE5uqHsh+SkIow9bZC/vlaDpuHk2HxjmcficDTjgLYUFUoHZNuxLhaAjIBuBS4WQEj8BRPeMjxZ3y+3oZzPZF7D6qgaGIuGZMrkhacHiUXQ3Crc8XYn0la2YqYiHRwTw/gyWP+SrDXVUNiR3yMdap/uxrbj6NSNbxlrORKux8Y1rwCKGAcfWO8MKYKWufoZoE7iRtc1vgcgdtKz9Cc2+Xon+cEsUh/J5XRmRGHp1WmEsBODv+9Mndv1tRvTYSqM52xBg+r2xGibt7s49o5IhMlMAHPdVydnUPkg3j1oqV3XuYghiNEA+ysQVPxkwpvokAeDs+TWB05+5lXt/lncfc1nunILtxk/1jBFF7tOUF2zP+uVtMltwXMAtMNMRXmmWewPnqoA9fDj6c047iNl/CQOKMt0L3tfFmTNiF3hPCPJOjhCFC+vD8u5WecJF6YlN7u2UfsEINNNmqjompbBxAoK2oU10HotLycckjWFRtT3ZrEBrdG0+k8gUQu8ofH0e3Bb0Ms
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(18002099003)(56012099003)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dnZNdis4MFpCak1PclBXNjFLQktoTGtYdnNUeExyVzUrcktGNHg4RzhqY25r?=
 =?utf-8?B?WmR0THZuVGNVRXJLOUFuYWJtYkNRckRud2NlSG5jTk0rZlNrazluT0dKMTNj?=
 =?utf-8?B?NWh2UEU3Nm1MSTc1ejNzK29OUjkwaDlGUk5CckRBb09waUpHY3RjeDJENlBX?=
 =?utf-8?B?YjY3S1RndFdiT25vT1RLSDBHOG45bk0weU1oVW1FMEhIcFNkcDN4QldvNU5p?=
 =?utf-8?B?T1pTSTYxckZIMlFLZEFnU2EwS2tkSEV1dTlPYmU1Vnp5Qm1kNnplTUVBYlA5?=
 =?utf-8?B?UEZqOGd5QzJveHFURGVaNi9ZQ1lWQS82NFZUd2lmYk5SQjlHM2VYV0Q0cmgw?=
 =?utf-8?B?OUFVWHFjNTU5K3FZUVljSXZleHBFKy9IMXY2aWJ3bS9KY0ZnS0ltMVJRV0dE?=
 =?utf-8?B?UVl5VjZEQzNuZFZ0KzViV1ZmbndzUHdKUWNaaHpKdTlSbWlBdHNueTlCeHdV?=
 =?utf-8?B?NzdnSVRnUWlLRWticWRTK2d0SDJvMmZrY0Y5L3dPSTAvQjBjaGF4Nm53b3Ji?=
 =?utf-8?B?dXVXZmwyeWUrWWg1TFJTa2dRWFpSbFhCVGs2Q1d0MDJEN0ZMMHRCaGtlVThm?=
 =?utf-8?B?Tkx0ZHg5OU1QMm9PcmtCaGpJMWNPYlllblJsR2svTnlseUg3bkQvaFVUNlJu?=
 =?utf-8?B?MVZxVXN5ek40bktwNkk2WWdnSzdEeE5GZS9kVVFtZW8zZnlvN05lT05VT1cz?=
 =?utf-8?B?ZVh2M3lvekpmMGE1SnBkSE5xU0ZBdXN1S3dUVVd1NTFybGdTY0ZTTkU4ZnlT?=
 =?utf-8?B?SmFpVGlDQ2g0WTRiTU9MM0NkYlFqUThKUjB3dks1VjhLZEtrVW45bWd0RjZD?=
 =?utf-8?B?L2V6OXdiRGVtRk15bXF3S096TERnWmdDRTNEdlJpNW5lbU01VEQzcm1hYUVz?=
 =?utf-8?B?Y3Q0c05VSFdRNFBmN2tMeXgwWEtDcElNNnZWendIbEZGRmpqZHRUcEl3YklO?=
 =?utf-8?B?OHFOeVJqblREUEt1KytTeHZBcDBtY21xc24rTEQxQUxYektxUnk3d0d3dGYx?=
 =?utf-8?B?bFVjbVZYTXhSSzhienNGODRIZnFkQ2ZkTFBsN3E3azdiWDdFWWZOMDhNUjdL?=
 =?utf-8?B?UFNFcWZhbXVQdXhsM0hkaytNaE15Q3VGaGREVkExdHFMWWJobDZJZnNvMEg5?=
 =?utf-8?B?SEFPbVhVL3crT3g2ZENtWjRGNWRrS3MzSXUyNEZDNDYzdC9VT3FraXZWL3hy?=
 =?utf-8?B?UTBWcm0xcmx3Z0hjeUdQTUNGNW9YWWNuNkFjdGo0WEpLbi9CMUJmWnRoMWlP?=
 =?utf-8?B?SExwMEpjSlo4VlRIMk5QL0Z6N1RuY1AzVWxwWC9LN1VJZW5CYXo0bXpxUVg2?=
 =?utf-8?B?ZDlveUd6QVc0TmN0MW5JTXNzSkRueUVvRjl3SUZDWWk3NUMvV3dqU0w2L2Nh?=
 =?utf-8?B?VXg3Qnh6R2tjV0hjTmNidThFbUhSbWZpTUFTZXNKbnJLcVM3ZThNWkd1NkZ3?=
 =?utf-8?B?MDdmT0t1bWltMW90aUVGTStjK2pMWHNXNmtScmh3YUFpUUxVOWVUL3pxMkdS?=
 =?utf-8?B?amxCUXFiTzNmZ2hFMVNUeXA0QnhhTE9laHR6UG5NMGt1RnAzS1hNRlpISERv?=
 =?utf-8?B?SUorQ21oKzR4ODhtTmg4WlZHV0srWHVISGpHdjJvcS9uaXd0Wk1sYmpRbFY4?=
 =?utf-8?B?VlJneFFNaGFqY0VOakNPeTcvWW9kbGQ3T2VNaFZaNXFnNGFyU3BVYkkrWk9Q?=
 =?utf-8?B?c3c4eHFDYmd5MUU2VHlONzNLamFaZG8yK3AxZEJXbTdmaDh3OGZGMUprZitL?=
 =?utf-8?B?OVluam51V1FrQTgybFltQnFXZzgyc0xKODdDUWJIbGRGSWpjKzNldDc2c054?=
 =?utf-8?B?YjdMZDQxYlNFRDJIRTJCaWZvdVpPN2llRDBwNSsxMnV0WmJjckxzU2xjVHA5?=
 =?utf-8?B?K1Uwa2VOdnUwdmpMY1JwbVlHdmlIVDQ1NCs0NndCNUEvM0U3NERGMGs3bFB0?=
 =?utf-8?B?NkVpdEZWN3F4cGJQQUJRcVRKdW5MTXRzRWY2c3Vpc0JtM09RUGpPUG1ucGxj?=
 =?utf-8?B?ZDhDUUkvRmprc3Y1M0dKVUZNVEtNVmFXVlZobjl1UEtNZXNOZUpHYVQzeXQz?=
 =?utf-8?B?MzNlSEVxVTFzTk9YU0ZpcTk3RWRaa3ZONnhURWtqaFQ5U3V6cG9FWXBiZmhV?=
 =?utf-8?B?cjJhcm4zdE4rM1YwRjd4cThnV25DSGF1TWc3VjBxaWl5TlBwdlNwb0RmcDBF?=
 =?utf-8?B?eDhvQ3lPMGxLS0V2VGNKbWV4Um01dmswRUM2V2tmMjRDWUhxczMyTnpHQzJT?=
 =?utf-8?B?ZndtTmZVaEJlZE8rUGxxYkJ4S25XRG8vYnZyMVU1VEpJRWg0TGkyOFNqZWRw?=
 =?utf-8?B?SmNkcEFsTmNaRStsSGlZZk1jTkk2cENjbW56TG1lRmRBTk0wdlBkZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	SE8noafVkj4/WewW+E7cya3v61qArn0yCldRn9WtmUta8A82y41EjrgtPvJqF8vcr7e2x6bUE9yfX8prepdymi8rMJnFIMwb1DEuhsiqEI5jDd8kpqhQE5jaDNr0MtrRKzQ/eZnmD8aGTudrdKfmnG5Bhj3ule+JxJdXgfPSlEOFQOQOXhUi6f0SAtebrUNy01bCOszqBilMDgAUxzFmiw1I48tnFpVyrZkKEg8OP7d2O3xfsHFhujFPTH3TKKYcKoasBz+iogbcu1J8B4O/EqIIG7ATph06kpoF20zYWXVwOhHtb1Tgywl8jPYVdrIt7lSCGVFePVIoNvPyhlxBVQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 168bbebe-8313-4fcf-9505-08de93e0a463
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2026 13:30:17.2019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6FEG6t8wsEUPXBWSf0Y7tMGhItlSnD43Qipwyrr5DARMkCX49aDEe2avMo5EAKWelYXc4jocbpZsxfs8GorDKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB7022
X-Proofpoint-ORIG-GUID: JG6GOKNNfQqp31SP14NTyCGRzCBna5j3
X-Authority-Analysis: v=2.4 cv=BqaQAIX5 c=1 sm=1 tr=0 ts=69d3b56f cx=c_pps
 a=8rPU+5JwkgyrUHCwJFKWcg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=_jAD5XSDOtq9-5Nde2OG:22 a=UoFAZm-l2efYPWSGiM4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDEzMyBTYWx0ZWRfX9vTUxmmp4sC3
 FBkgPilxfN+mDiWgWgOfg+/W4oUqXIztHe32siT5n6b1r5YRdl2ZG4g8Oc9SahK23HcD77XfWYz
 mmDZ2633Ifos/XkL7BCS7Dptq4hmhygD0lIDWRahVFtzjQDJZlHxQANg08qOv1DZIi7aLOTSwks
 a/g8Ghe+80wSzmLHawpFVSOgj1oNpTGj0d2QgsE5jCTMquGLxwSioucDNkV122actHisD2c0GTX
 JTCjxSqNvWCmYGc/aaPljfNa+MU06m3q6D91FdJ5IgNHqsAUmah1bqT90SSEVtQkri2uH+otgmY
 +nEW3ScmHDD1FTABzICK9i35VHtqRijTUrtBNIaZDgKjjSUqJrjSEegCmNLgDOLtPmMUDX7mVGp
 7wqg5g3DRtC2vImvJhsEk1tviGmmIRgIQPQFLSm2MM+yWhm75ydARESrwmDlKDCuu8BuGr0WFMp
 zPpLJZpTtfzO0niBTdg==
X-Proofpoint-GUID: JG6GOKNNfQqp31SP14NTyCGRzCBna5j3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604060133
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	TAGGED_FROM(0.00)[bounces-8487-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[baylibre.com,metafoo.de,analog.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[LV9PR03MB8414.namprd03.prod.outlook.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,analog.com:dkim];
	DKIM_TRACE(0.00)[analog.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Radu.Sabau@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-0.985];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4DE053A390F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2FiYXUsIFJhZHUgYm9n
ZGFuDQo+IFNlbnQ6IE1vbmRheSwgQXByaWwgNiwgMjAyNiAyOjA4IFBNDQo+IA0KPiAuLi4NCj4g
DQo+ID4gPiA+ICAjZGVmaW5lIEFENDY5MV9DSEFOTkVMKGNoKQ0KPiA+ID4gCVwNCj4gPiA+ID4g
IAl7CQkJCQkJCQlcDQo+ID4gPiA+ICAJCS50eXBlID0gSUlPX1ZPTFRBR0UsCQkJCQlcDQo+ID4g
PiA+IEBAIC0xMjIsMTEgKzE1NSw5IEBAIHN0cnVjdCBhZDQ2OTFfY2hpcF9pbmZvIHsNCj4gPiA+
ID4gIAkJLmluZm9fbWFza19zaGFyZWRfYnlfYWxsID0gQklUKElJT19DSEFOX0lORk9fU0NBTEUp
LA0KPiA+ID4gCVwNCj4gPiA+ID4gIAkJLmNoYW5uZWwgPSBjaCwJCQkJCQlcDQo+ID4gPiA+ICAJ
CS5zY2FuX2luZGV4ID0gY2gsCQkJCQlcDQo+ID4gPiA+IC0JCS5zY2FuX3R5cGUgPSB7CQkJCQkJ
XA0KPiA+ID4gPiAtCQkJLnNpZ24gPSAndScsCQkJCQlcDQo+ID4gPiA+IC0JCQkucmVhbGJpdHMg
PSAxNiwJCQkJCVwNCj4gPiA+ID4gLQkJCS5zdG9yYWdlYml0cyA9IDE2LAkJCQlcDQo+ID4gPiA+
IC0JCX0sCQkJCQkJCVwNCj4gPiA+ID4gKwkJLmhhc19leHRfc2Nhbl90eXBlID0gMSwNCj4gPiA+
IAlcDQo+ID4gPiA+ICsJCS5leHRfc2Nhbl90eXBlID0gYWQ0NjkxX3NjYW5fdHlwZXMsCQkJXA0K
PiA+ID4gPiArCQkubnVtX2V4dF9zY2FuX3R5cGUgPSBBUlJBWV9TSVpFKGFkNDY5MV9zY2FuX3R5
cGVzKSwNCj4gPiA+IAlcDQo+ID4gPg0KPiA+ID4gVXN1YWxseSwgd2UganVzdCBtYWtlIHR3byBz
ZXBhcnRlIGFkNDY5MV9jaGlwX2luZm8gc3RydWN0cyBmb3Igb2ZmbG9hZA0KPiA+ID4gdnMuIG5v
dCBvZmZsb2FkLg0KPiA+ID4NCj4gPiA+IGV4dF9zY2FuX3R5cGUgaXMgZ2VuZXJhbGx5IG9ubHkg
dXNlZCB3aGVuIHRoZSBzY2FuIHR5cGUgY2FuIGNoYW5nZQ0KPiA+ID4gZHluYW1pY2FsbHkgYWZ0
ZXIgcHJvYmUuDQo+ID4gPg0KPiA+DQo+ID4gU28sIGp1c3QgdG8gYmUgY2xlYXIsIHlvdSBhcmUg
c2F5aW5nIEkgc2hvdWxkIGhhdmUgZGlmZmVyZW50IGNoaXBfaW5mbyBzdHJ1Y3RzDQo+ID4gYW5k
IGNoYW5nZSB0aGUgdHJpZ2dlcmVkLWJ1ZmZlciBmb3Igb2ZmbG9hZCBvbmVzIGlmIG9mZmxvYWQg
aXMgcHJlc2VudD8NCj4gPiBJIGFtIGFza2luZyBzaW5jZSBvZmZsb2FkIGhhcyBkaWZmZXJlbnQg
c2NhbiB0eXBlcyBhcyB3ZWxsLCBhbmQgdGhpcyB3b3VsZA0KPiA+IG1lYW4gMyBkaWZmZXJlbnQg
Y2hpcF9pbmZvIHN0cnVjdHMgZm9yIGVhY2ggY2hpcCAtPiB0b3RhbCBvZiAxMiBjaGlwX2luZm8N
Cj4gc3RydWN0cywNCj4gPiBlYWNoIHdpdGggYSBkaWZmZXJlbnQgY2hhbm5lbCBhcnJheSwgb3Ig
cGVyaGFwcyB0aGVyZSBpcyBhIG1vcmUgY29tcGFjdCB3YXkNCj4gPiB0byBoYXZlIHRoaXMgaW1w
bGVtZW50ZWQuDQo+ID4gSSBjb3VsZCBtYWtlIHRoZSBjaGFubmVsIGFycmF5cyB1c2UgdGhlIHNh
bWUgbWFjcm8gYW5kIGhhdmUgdGhlIHNjYW5fdHlwZQ0KPiA+IHJldmVyc2VkIHRvIHN0b3JhZ2Ug
YW5kIHNoaWZ0IGRvbmUgYXMgcGFyYW1ldGVycy4NCj4gPg0KPiANCj4gSSBoYXZlIGdpdmVuIHRo
aXMgYSB0aG91Z2h0IGFuZCBJIHRoaW5rIHRoaXMgY291bGQgYmUgZG9uZSBpbiBhIG1vcmUgY29t
cGFjdA0KPiB3YXk6DQo+IA0KPiAxLiBQYXJhbWV0cml6ZSBBRDQ2OTFfQ0hBTk5FTCB0byBhY2Nl
cHQgc3RvcmFnZWJpdHMgYW5kIHNoaWZ0LCB0aGVuIGRlZmluZQ0KPiA0IGNoYW5uZWwNCj4gYXJy
YXlzOg0KPiANCj4gCS0gYWQ0NjkxX2NoYW5uZWxzW10gLSAxNmNoICsgdGltZXN0YW1wICh0cmln
Z2VyZWQtYnVmZmVyIHBhdGgpDQo+IAktIGFkNDY5M19jaGFubmVsc1tdIC0gOGNoICsgdGltZXN0
YW1wICh0cmlnZ2VyZWQtYnVmZmVyIHBhdGgpDQo+IAktIGFkNDY5MV9vZmZsb2FkX2Nudl9jaGFu
bmVsc1tdIC0gMTYgZW50cmllcywgc3RvcmFnZWJpdHM9MzIsIHNoaWZ0ID0NCj4gMA0KPiAJLSBh
ZDQ2OTFfb2ZmbG9hZF9tYW51YWxfY2hhbm5lbHNbXSAtIDE2IGVudHJpZXMsIHN0b3JhZ2ViaXRz
PTMyLA0KPiBzaGlmdD0xNg0KPiANCj4gICAgIFRoZSB0d28gb2ZmbG9hZCBhcnJheXMgYXJlIHNo
YXJlZCBhY3Jvc3MgYm90aCBjaGlwIGZhbWlsaWVzLiBTaW5jZQ0KPiBudW1fY2hhbm5lbHMNCj4g
ICAgIGJvdW5kIHRoZSBpbnRlcmF0aW9uIGluIHRoZSBJSU8gY29yZSwgdGhlIDhjaCBjaGlwcyBz
aW1wbHkgdXNlIHRoZSBmaXJzdCA4DQo+IGVudHJpZXMgb2YNCj4gICAgIHRoZSAxNi1lbnRyeSBv
ZmZsb2FkIGFycmF5cy4gVHJpZ2dlcmVkLWJ1ZmZlciBwYXRoIHdvdWxkIG5lZWQgZGlmZmVyZW50
DQo+IGNoYW5uZWwNCj4gICAgIGFycmF5cyBzaW5jZSB0aGUgdGltZXN0YW1wIGluZGV4IHdvdWxk
IGJlIGRpZmZlcmVudCwgYW5kIG9mZmxvYWQgZG9lc24ndCB1c2UNCj4gICAgIHRpbWVzdGFtcC4N
Cj4gDQo+IDIuIGNoaXBfaW5mbyBjb3VsZCB0aGVuIHN0YXkgYXQgMiBzdHJ1Y3RzLCBhbmQgaGF2
ZSBjaGFubmVscyBzZWxlY3RlZCBhdCBwcm9iZQ0KPiBmb3IgdGhlDQo+IGluZGlvX2Rldiwgb3Ig
aGF2ZSA0IGNoaXAgaW5mbyBzdHJ1Y3RzIGVhY2ggaGF2aW5nIGl0cyBvd24gY2hhbm5lbHMgYXNz
aWduZWQsDQo+IGFuZCBvbmx5DQo+IG51bV9jaGFubmVscyBjb3VsZCBiZSBjaGFuZ2VkIGF0IHBy
b2JlLg0KPiANCg0KSSBhbHNvIGhhdmUgdG8gbWVudGlvbiB0aGF0IHRoZSBvdmVyc2FtcGxpbmcg
Y29tbWl0IHdvdWxkIHRoZW4gaW1wbGVtZW50DQpBRDQ2OTFfTUFOVUFMX0NIQU5ORUwgbWFjcm8g
d2hpY2ggd291bGQgbWlzcyB0aGUgT1ZFUlNBTVBMSU5HDQppbmZvbWFzaywgYW5kIG9mZmxvYWRf
bWFudWFsX2NoYW5uZWxzIHdpbGwgYmUgZGVjbGFyZWQgdXNpbmcgaXQuDQpNb3JlIHRoYW4gdGhp
cywgdGhhdCBjb21taXQgd291bGQgYWxzbyBhZGQgb3RoZXIgYWQ0NjkxX21hbnVhbF9jaGFubmVs
c1tdDQphbmQgYWQ0NjkzX21hbnVhbF9jaGFubmVsc1tdIGFycmF5cyB0aGF0IHdvdWxkIHVzZSB0
aGF0IE1BQ1JPIGFzIHdlbGwuDQoNClRoZW4sIGNoaXBfaW5mbyB3b3VsZCBoYXZlIGFkNDY5MS85
M19jaGFubmVscyBhc3NpZ25lZCB0byBpdCBieSBkZWZhdWx0LA0KYW5kIGluZGlvX2Rldi0+Y2hh
bm5lbHMgd2lsbCBsYXRlciBiZSBhc3NpZ25lZCBhdCBwcm9iZSwgZGVwZW5kaW5nIG9uIHRoZQ0K
bW9kZSBhbmQgb2ZmbG9hZC4NCg0KSWYgZGlmZmVyZW50IGNoaXBfaW5mbyBzdHJ1Y3RzIHdvdWxk
IGJlIHdhbnRlZCBzdGlsbCwgdGhlbiBteSBiZXN0IGd1ZXNzIGlzDQp0byBoYXZlIGRpZmZlcmVu
dCBpbmZvIHN0cnVjdHVyZXMgKHBlcmhhcHMgbmV3IHR5cGVzKSBpbiBjaGlwX2luZm8gYnkgZGVm
YXVsdC4NClNvbWV0aGluZyBsaWtlICpzd19pbmZvIGFuZCAqb2ZmbG9hZF9pbmZvLg0KRWFjaCBv
bmUgd291bGQgY29udGFpbiBhbGwgdGhlIHByZS1kZWZpbmVkIGNoYW5uZWwgYXJyYXlzIGluIHRo
ZW0NCihjaGFubmVscyBhbmQgbWFudWFsX2NoYW5uZWxzKSBhbmQgc28gaGF2ZSBhZDQ2OTFfc3df
aW5mbyBhbmQgYWQ0NjkxX29mZmxvYWRfaW5mby4NCkFmdGVyIHNvLCBjaGlwX2luZm8gd2lsbCBh
bHNvIGNvbnRhaW4gYmVzaWRlcyB0aGVzZSAyIGluZm8gc3RydWN0dXJlcywgbnVtX2NoYW5uZWxz
IGFuZCBtYXhfcmF0ZS4NCkF0IHByb2JlIGluZGlvX2RldiBhc3NpZ25tZW50cyB3aWxsIGJlIG1h
ZGUgZnJvbSB0aGUgY2hpcF9pbmZvIGVudGlyZWx5Lg0KDQpXaGF0J3MgeW91ciBndXlzIHRha2Ug
b24gdGhpcz8gSSBhbSBrZWVuIHRvIGhlYXJpbmcgeW91ciB0aG91Z2h0cyBhYm91dCB0aGlzLg0K
DQpUaGFua3MsDQpSYWR1DQogDQo=

