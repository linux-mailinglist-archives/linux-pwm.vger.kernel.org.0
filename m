Return-Path: <linux-pwm+bounces-8366-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNX+GM/kw2lvugQAu9opvQ
	(envelope-from <linux-pwm+bounces-8366-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 14:36:15 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4E7325E4A
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 14:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31808302DA3C
	for <lists+linux-pwm@lfdr.de>; Wed, 25 Mar 2026 12:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33843D525F;
	Wed, 25 Mar 2026 12:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xgY2ucdC"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD162EC081;
	Wed, 25 Mar 2026 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774442891; cv=fail; b=b5XYfddHJ4+RWBuJImZLagOb8uJLZb+Rm8mcSQQBCmlOVy9x7D4uEuMsE7w0VfA9JcXcYKYSgffd2Oe9PBdXAZWHlYbfINfEYyj9K5jefqMogj3UA9C6HmiLt+H2ABB+BKWX6kmqgaKVTFN4TJkPfDb7yogr7/rfcd/S2A70Szw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774442891; c=relaxed/simple;
	bh=uWgKC4O6Ok+3+s0trK6gLLCuzUaihJmCr7AGPuu8UzQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lYMN5KixjGg4+0Dd5nzON+1mWZ8IxVr/HU8lhDGA+p9jjL/JqMIHjMG4mnxrEofV5iYiozfcO3ABL0FoOugxW0UsWUXk3Y3ZLR4Cez2LjG4/cHAeIj61LDoI9tWbrG+oKm6cPy0YS2KgEjrSEMUbZezDhGyVt+/sBDcIx8PxowU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xgY2ucdC; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PAwDRD3463495;
	Wed, 25 Mar 2026 08:47:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=uWgKC
	4O6Ok+3+s0trK6gLLCuzUaihJmCr7AGPuu8UzQ=; b=xgY2ucdCJDWpeQ0GcvXo7
	l9VHH3ZgvEFC0VGexxOrGKJ1FiudShqup8ne9Al+q6giNy1K1EkXcjbHvwXyNJAA
	wdM9sxbNklcPkEnjSTzDSgXm6Tupb5q7YTUWJM2qKNnKl/dxmsOc39SMg4po6tDj
	Xfyn5hNSULWNjMc1ns7k1lkrBCf09gt8ufP/uh5QzfRBOzRO7NPENndPv+v5rAfO
	MIYDI1tD+nY/BFUDcrGILErFfj667k0I6hxl6NFBxz6pEapFgr6nJ9IVaEoB8MAm
	4sPMklWMEbggPK2oc1Xp+8BNS3hWCGdorOrt6eNBiYssOFVWWRLOOGGjXXQcISLh
	A==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010052.outbound.protection.outlook.com [52.101.56.52])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4d45m1k159-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 08:47:48 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AOkn/g0blMfn37f9lSoAe/z1yOR/BLHnWEYrs3fk3W6GGQR/NHjxJ3vt7QiaRGKx+LlScOyxoqagE9GXmsBLz9An4KBjm8IOiNMKHf3UTj5VJ6x/ZPzIbVC3FiKIZLmcVD479gYzmYN/9t+JAZWt9KkZ2zvj0XzCc2THTFWif7MAJwcKG8nHwKP2Cq9NMb9qXaTIzuxGuJQFz0QFy6R9XP+Hley6EWwcRFkW801syH8MzQvOSm96rgavyUPuhS7hX/sjdmp7NL8RISoP1aIJrjfCPNAuFgBpR5YaI9341ZsJTr5c9p67pMThBmQRCCtypcZO7/f6MWxzaZAkOuC7Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uWgKC4O6Ok+3+s0trK6gLLCuzUaihJmCr7AGPuu8UzQ=;
 b=V7NcbHpc0M75Z+861pgzKarUtdIQSJAwyxY/hPW3QtRSm9UBX1FXWDL9ynzazf7wYkTU6c9MZO62QwLxnOnc9BMEeDPxr51SBWuZ5Ds9zaqWbdv70hO4tUCiUeRjbbyN2sHpb3/+ccrmjGbCJARIXqszFgh51g1rlqdna3gYKsFMbIt4u46vJdX96GPCXPEXNmY2IEGBgieXVf8Ow3vHNo/BRBiuLG28uuLhKkL9toVjyLQMa+8lDuyU6ZgADleJHpGgCZq2yCOWQBYxmJk+alAbsBlAkyDfbb0sT6Ow6xY6mvZqhPCI8gRooCjEkaRXu3os0gLiIN8ZWAv2TpSE/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SA5PR03MB8425.namprd03.prod.outlook.com (2603:10b6:806:47b::8)
 by CO1PR03MB7986.namprd03.prod.outlook.com (2603:10b6:303:276::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 12:47:44 +0000
Received: from SA5PR03MB8425.namprd03.prod.outlook.com
 ([fe80::ad3e:e026:f2fa:bf5f]) by SA5PR03MB8425.namprd03.prod.outlook.com
 ([fe80::ad3e:e026:f2fa:bf5f%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 12:47:44 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: =?utf-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<ukleinek@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski
	<brgl@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: RE: [PATCH v4 3/4] iio: adc: ad4691: add triggered buffer support
Thread-Topic: [PATCH v4 3/4] iio: adc: ad4691: add triggered buffer support
Thread-Index: AQHcuFlEE/Kp5w+npk+HoCBYC6Jbw7W9oSkAgAGYn5A=
Date: Wed, 25 Mar 2026 12:47:44 +0000
Message-ID:
 <SA5PR03MB84250500F1FB9567F7FD2701F749A@SA5PR03MB8425.namprd03.prod.outlook.com>
References:
 <20260320-ad4692-multichannel-sar-adc-driver-v4-0-052c1050507a@analog.com>
	 <20260320-ad4692-multichannel-sar-adc-driver-v4-3-052c1050507a@analog.com>
 <83d87ff35002e5c7b9448a5ee7f2791a63c38c38.camel@gmail.com>
In-Reply-To: <83d87ff35002e5c7b9448a5ee7f2791a63c38c38.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA5PR03MB8425:EE_|CO1PR03MB7986:EE_
x-ms-office365-filtering-correlation-id: 6ca8893a-00c1-4362-92ce-08de8a6cb5e8
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700021|921020|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 q7vN8uTOdOAbji7e78q6fqV8y8lh7z9WsdS3f4WFi1BG5Dc61itiAkyjqmILIGSB41SP29rXXmEEk6JK7DwB22zesbR3QD5gvisigLU30Wy1LSZrNJHxr/S9jk02VA4uTeXbS7pcG8gKjXKoqAXn8s9PabUnUrV4YNzdclfvbW5fOKMLTAsJkyDVTcEQqlpnWojRwnEq2dhxMopdz3o3uVNrizAaV6mU3DnYiPmJWEbZ4jjg1YfVBK7Aj3vusTQ+GQDgd4bqmSYI0XJQ/GE/L4DbtEujnDkMWduNYGVnxqOmsZ33lYvcw8wsJmThwZXCUDsRyT6FPxyK7Rm2mlfs9QXQJcxkYSXXrvbqsrAOtAOCyB9EKj7EQ8KNbRkB3Y6fGoHq6WbgV01nmlbUOOOvuoOXQwSlX6gJghgIbAheTvcckpsVvT173Q+/puOmXEOAapYopM1PTgZrM83Ndjg/lJsFWCvJ7LnoXZR9vXfFwJwR3nc7csGqy6XgpGMydf7OPNjJsdBUEMv4v+X/jiuf6d2HyQir6D59dCwNMaFXkCn3L9zQ4tL2BGGnQAKshjPrOzl7JwbKxDdQXdbhwq6kJeVl5cCSlhjr0DImwVHFU0cF3O06fktGrXnvQxKCAU4k9eeOiPpEhEWj8pzFy8q0Pl8Q34v5VFmkF8InyP5kH7hC96w8NKFxDjhVXxjWk8/lVEfF0WVC/STwzPIetpQPwGsQ8EKeI+yUWALGQoccZSW275WTqZMhFtIjAw3KUFxIAuvWZ1ctOcHw/NNSSSRsxpYQSZQJDetAjj4bzTkWbfb3xrXYomVBEeHSZjlGUAVN
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PR03MB8425.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700021)(921020)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RFVneU4wUWlURnA5MFQ0akkyenFCVTFrMERHVGJJVzRIalVhMWJVeG5VK2dX?=
 =?utf-8?B?eGlGN2JDK1ZYS1VQais4RTFjRThpblpyMnFIWCtVMFlXOEN5b1pVWjU4S2JU?=
 =?utf-8?B?VXI0RU50a202a0psQlJHbVpxVzJ6dExmanA2S0RFVVlnOFJ4S0l4a0RzckZK?=
 =?utf-8?B?UURjT1dlNE1jdHhRQVlxdTRjTk9OVHBwYjhicWpTd2FtdnN1c2tTTGp2dmZC?=
 =?utf-8?B?elBYNW5yT3IvS2g1RlQ0MXBlT1BBbVFFR3FnaklrbUZYQVh4ZGRpVHMyWkw1?=
 =?utf-8?B?MDRUYXNWQ2h6TlNrRWUyL0VkVGphWmNvWmN2UFpraW12SEg4aFRrOHg3Q0hj?=
 =?utf-8?B?MThVb1MrdHNLMlJucnI2Tk84RkI0dmFXNnZYTDZCYkExRjNHMXU3OFB0OWda?=
 =?utf-8?B?MEhFOHhtamRZczM5VWFYMHBQK2tzLzlHNEpRaGtzUVI3UXV2cStZS2VKeWVR?=
 =?utf-8?B?bXUxMWZVOGxXaCt1S21uWldpZWNpV2xMcXZzUTJuc24yV2FuZklsZDluZkQz?=
 =?utf-8?B?aGpJdmdzcFZ5RDZYdlRkSlBJZVhqenkyelV4Y0VTOThWVThBcjVQM1JxYStz?=
 =?utf-8?B?UDNTRjFyRGtzMU14S2FGdk8yMTRIZmZRTDdIZ3hBWnlxNjVoSDhmWGc4ZzdK?=
 =?utf-8?B?OXFZdDVta1N0L0l6bi9HN0VPYVdET2xPMWRIbXJsbW1BSDIzdnRvUHNBbHBa?=
 =?utf-8?B?WXFPTHMrdUc3RzRONFdENVR3aGRBRGJDMng1blBKam43N0xVd2Juc3NaclUr?=
 =?utf-8?B?Y2FLOWtXN1NSbEgvZDRBYjRTMUZDeFVkc1V3cGVXdFgvQmxGSVNWbnNvL25x?=
 =?utf-8?B?Y28zVDR2ek1VOXE5cm5mN2hlYVdYSjBjNDRrSTlOc09XTXdPamxSTkZKM2l3?=
 =?utf-8?B?TVBLWTZtVy9mRUk2Uk1CWnV0ZHo4aUgvdHNiS2p6TVhJaDlRazgzcWhXbG54?=
 =?utf-8?B?cmNCZzNUZWFpSzAxcjU4S3BkMy9Pelg3NmNBdHZYSnZSUHFudFRhM2tMTWlZ?=
 =?utf-8?B?bGZIUlpBaVAwWU8wSlhRbzU5SVBENCtkbDdJaG0xeE5CRmI3TjlTT2ppbzQr?=
 =?utf-8?B?VFZpSHFzMDNwUHo0eW85ZTJpNm1mSEFwS1BWclNIL00wS2JWSWdzRlMyMUpO?=
 =?utf-8?B?bHczWmQvUEtnaDVpOGtDVXFFTDVvRkE1em5kdStZWXZZbDIvZVVuMGJncnRM?=
 =?utf-8?B?SXkxa0RURUdZaENEUkZQM3FwT29TZnVzNDhWMFhvQ2ZxV1VoeVQyN0p1WUV2?=
 =?utf-8?B?b0ViYnVyTkR4OTRFS2ltdUVsZDBlY09kSDY3VmNFbFoyelZqdHU3WDRTcnpU?=
 =?utf-8?B?N0IwWGowRXBCNW5NcjhpeTJPN3JBRUF0enhCek1Kd3NrY21nbkZWaUswYkQ1?=
 =?utf-8?B?UDIwVzVlcFc5WER4eGdIWm5CeDlaZmJkdW8wTW8xY1plT2N1RUZ1S202YWdo?=
 =?utf-8?B?K3VwRWVMeDBSRGJOQ2RENXNzLzhRMUxkM29waU9HaERYekdBSGtVbFh3TUJL?=
 =?utf-8?B?aStKdVk1UXpvbVc0Z3JOcjdHbVJkQ0p6SnJuU3Nia0NGSzViNkxOVVdIT2h5?=
 =?utf-8?B?b1prdE01TEFueGxaQlhaMC9wRi8xbGx2dmw4djFBbjRmOS9NWHlhOHdQOEVj?=
 =?utf-8?B?ekdTampteUFOekNtWTI2czh4S1ZBWFZmUEt1a0s2dGsxVFkwTTdqMUZLZnFz?=
 =?utf-8?B?dFVxL2F0Vld0eHZ2QWpMTDNDVlJVL1NMdUpTTDhrR0FobkI1UExqL1g5Tkxu?=
 =?utf-8?B?SFVrNU9hQXZ0c2pYcWl0c2s3YjhHNzhmWWtDYlJVN2ZSc2ZHcEVJSmlKVUdY?=
 =?utf-8?B?Q3BYVkgyVk1vNnZ5aWtmVU1YR0ltdGxXYkthVlNmeDV3VGFla0VWMDFHc2t6?=
 =?utf-8?B?dE85TU8yQTU4eEVrR09UK2tKdVVIdkFYcnVWOEM3QzZyMXpJU0dnd3hmOXpt?=
 =?utf-8?B?djFabTJPWEwxTnB4STNRc3pzVFVPcHpwNm1uL0pZWlZaYjI2SXFjRGdhTDIw?=
 =?utf-8?B?cFRJYk0ybWdPM3pINmhidlpFUThJRGpKV3lsTmFsSmQ0bE56WVBTRWZPK0Jo?=
 =?utf-8?B?T0xya1JQR2lseE1CTndjdkVDVTJUcWpmZ3dIN09CNmdZZjlQSkVuRW81ZXBr?=
 =?utf-8?B?UHY0cmpob3d1dHowaHN5aWYxb0VsdlhrS2FFcldSM3d0QVJBMXJOZEtJU056?=
 =?utf-8?B?QTJCRGJrWnhaSGJ5RUYyQkdsbmh4TzhvSkttZFFNT2dldWxUUVk0QWRhSEFK?=
 =?utf-8?B?OWViNCs2UlZKRlJUaTZCTW5mSWhGUnlPaTEzQjZiV1pMdndrODdrbjV4OUdK?=
 =?utf-8?B?amRzdnR4VmJ3REYrYlJyV1FiekNyK0xodHlVekIwNFVvbnltTmFydz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	OsLxDeJPGyEP2vJoVMF9wbNa1tFBJUDeJU+VB3bV0/HoQ5/wshgpaU7qLBV/qKwmnAKebxf8pzlyU4OHJSaHq5SeRXOjB3VQMNdTsrYDV+xdixIDfSG9Odb9J5QfO70m4g4izVsjgwNB7fVbQNzx7xT6AlGFZmOAj7pNPE3CYHWIzcBnmdhi7zXpSD5asoeBUjDFk1gY9UPLUoS/9Rw9vwuTz0RIpdD8xv5X3HfIW1enFRF1S+V08hUvoyjNCdogxB4ChWJ7IzjELZ6GY/Puxop+dlqgSWboKs0x9na9KnA0vdu19MvXJm9Vjvt5a/hXd+GXaT5pfEIwWXS15qGouQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA5PR03MB8425.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ca8893a-00c1-4362-92ce-08de8a6cb5e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2026 12:47:44.5922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KHYThVv5xyNvASHooayQ91JBjFWSMW6fJLx1G9Ti5ZFCG1PrN5154yR53szJpvqM8gGURxv0BLVzX7UiGY+6kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB7986
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA5MSBTYWx0ZWRfXzjGpaopRvkQN
 kSWhhj4tW4Mr26LVTlF0LJ+Y+mscR89oWj4jJ02yrjagZycJ9lJBuM1LTFrt6df8MYEBt50Nlg4
 CG07qvH54+/WBXw9TTUUTd/x7RhU9EmDtYlJrlezL2qTrvRobdkbc9VLBOuop2ZPes1MD97O0ap
 +SwRzOXayiZa/PR7WAFrLmIxjWlgHVvxNcN9fOnRVWCpL/k1fBf5inqL47ZU520FxNvnnJTQTsU
 jbY7amGj6yDV31nt2jmLN9H1uqgG4VRodR8C89dSKmgJ7osQW9vcFqRYwr7fBrmk+zc3wB906Xe
 PsEjWKK0dBq2amW0ym2ODHb4TsG9/LKHZOVKQmbfUROyhkDVvAQVV4BKIh1W74HLCCdVFCP/DP7
 SfzxZDG0g1S/9JFF9GzvAs5MYBKnsG766POcKJfDNqG5PNe5BScVTTLgCHA1KtvvlqR2j7aK082
 v2qjNenTcNcKcC3UfJA==
X-Authority-Analysis: v=2.4 cv=He0ZjyE8 c=1 sm=1 tr=0 ts=69c3d974 cx=c_pps
 a=eLvx4Fye0krSvKD/jKlmuw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=pGLkceISAAAA:8 a=Gv9J3IXFRRFHxZ9d2ycA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: URDhCEX7wcichty7ylnl02kTOD84xGRx
X-Proofpoint-ORIG-GUID: URDhCEX7wcichty7ylnl02kTOD84xGRx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250091
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-8366-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,metafoo.de,analog.com,kernel.org,baylibre.com,pengutronix.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Radu.Sabau@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[analog.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-1.000];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BF4E7325E4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTnVubyBTw6EgPG5vbmFt
ZS5udW5vQGdtYWlsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgTWFyY2ggMjQsIDIwMjYgMjoyMyBQ
TQ0KDQouLi4NCg0KPiA+ICtzdGF0aWMgaW50IGFkNDY5MV9jbnZfYnVyc3RfYnVmZmVyX3Bvc3Rk
aXNhYmxlKHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBh
ZDQ2OTFfc3RhdGUgKnN0ID0gaWlvX3ByaXYoaW5kaW9fZGV2KTsNCj4gPiArCXN0cnVjdCBkZXZp
Y2UgKmRldiA9IHJlZ21hcF9nZXRfZGV2aWNlKHN0LT5yZWdtYXApOw0KPiA+ICsJaW50IHJldDsN
Cj4gPiArDQo+ID4gKwlkaXNhYmxlX2lycShzdC0+aXJxKTsNCj4gDQo+IFNob3VsZCB3ZSB1c2Ug
ZGlzYWJsZV9pcnFfc3luYygpPw0KDQpJc24ndCBkaXNhYmxlX2lycSgpIGFscmVhZHkgY2FsbGlu
ZyBzeW5jaHJvbml6ZV9pcnEoKSBpbnNpZGUgaXQ/IEkgY2FuJ3Qgc2VlDQpkaXNhYmxlX2lycV9z
eW5jKCkgaW4gdGhlIGN1cnJlbnQga2VybmVsLCBvbmx5IGRpc2FibGVfaXJxX25vc3luYygpLg0K
DQo+ID4gKw0KPiA+ICsJcmV0ID0gYWQ0NjkxX3NhbXBsaW5nX2VuYWJsZShzdCwgZmFsc2UpOw0K
PiA+ICsJaWYgKHJldCkNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsNCg0K

