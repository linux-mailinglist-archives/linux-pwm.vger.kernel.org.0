Return-Path: <linux-pwm+bounces-8268-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Kc2Khj+t2nrXwEAu9opvQ
	(envelope-from <linux-pwm+bounces-8268-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 13:56:56 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD13299B3F
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 13:56:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CCF1301C581
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Mar 2026 12:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75C9F396B78;
	Mon, 16 Mar 2026 12:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="sT4Pvk5C"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E740C396B68;
	Mon, 16 Mar 2026 12:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773665747; cv=fail; b=BEG+/hZU6xv4ZOcmoeC7vEHhI5Zwp4XI2sSXbTyy2CzWNbo6t9FeHd+kYFbdRt7O06X+gm1JpHk8GITedTkEsixLNJOu0w5VXy2Bpzu5KS59HO5tja92gYYtXy6RZeLErBYK+lNbHmwMwQb6CFcp6/K5FcECixfWgVur1jk+RIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773665747; c=relaxed/simple;
	bh=/7Fm9TA9CxstLMJKiKztdpy5b5zPv8C8Qx3K27p1xEE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=S+MR/x1b5GO7c48q00/EN+ev8CGvNUAxKQtJXjkSqYckg0nzBdbG6l8J37Bb4X/k3grEzMDyd4nZbbQ6S/qFMa5/X+fUATuvvV3OK0ABXbhQswbIhFVWFR04ZjfiJx48DaiStd0qU/pApCW/+ne3jC1m5ZeT9RZnlE5lTzJqQek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=sT4Pvk5C; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GCf0TI608976;
	Mon, 16 Mar 2026 08:55:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/7Fm9
	TA9CxstLMJKiKztdpy5b5zPv8C8Qx3K27p1xEE=; b=sT4Pvk5CbrIqlmj99q/Eu
	J9N/Gsp6HqDYsg9CnlSBM1Xvj+lauAV3xSBESsL2Cme8W+T0pL/khSVeeI/++cd/
	nNE2YPtr5sLAD1T1M4n0+xaqQGbEl0bNP8UMcAQ7bIM8SAFXitRDWd8iD7xBrw+D
	BqEuGQgfB2CdyeXmzT5kPGOAv5ZpN3wyNFPycJnml1pntWiBEcfkpotRD8hNetHS
	PVdj7ndT/LS+t92lKJtcgUDbjOMF+O+RYHn9qF96RwdE69ydyQqiMDTrE4jMntOX
	tS80PVXV8Pqils0M88vZEh8pdunVBUZLUKVhYcvPd7qFjhgFp71ZjYvD1AyGu/fr
	w==
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cx2em2cyq-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 08:55:28 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6e0+8VSbExyiD/4LfMX3DBok7TAXwSZYSjXEbxFk+7XL/kReu6NPHXGUQn7FDzGQyVHjnMEJERDYEZhZTwXfqMnMTChHBZiNdCNyt2BkqIzIgVCnlX9mdLLyAXIPRBnBEmtH88RlPFNTPrFdY/b/PvZclQQeH/fAJdNz+Zp0OdJYNvEatlkNSOAoRSy70vPe0lgUG7OqZ67dMX6ALMo61ecI+nEeLOgRyefcjM86UYz3LZTietwQhJZ/497CJwVhRiXVc4JTbLOu0f2D63bwHGUykQXYhSP/k7JXVnhre0SAQKKQVWEOijGsHQbAySDKhJZX0a++3eENuGadnxRBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/7Fm9TA9CxstLMJKiKztdpy5b5zPv8C8Qx3K27p1xEE=;
 b=CmH0B5Vy9gG/TAdK4jfOWro4KojCzgwK2S0FJbZ9j2M04t2LqMiRRDMwCNX8y21gTtIdj44WevEKtj4hHCjJuc0GhojRT87/+k+2XxheYpOdtRl20cTbNdp9fDBD+P1FOFK2yGzj6MIDcqiTHTZebOVBVNEC9WgUQcxsrR5TMI/5ef5XhSJqOPkkshrU4OFgutjGEZbPUvDKaO1FypAzc/agl7M3/Y0YGVf232l7Oidp4TYbE5K9Hj3UlsnsV2qzgTF1f/9OMgLrCZU8oEVj1UP+ncwEK9UJyh7sNM8Bx/+yJrZannwJ4P39t09vOAD3njk+mwElASCaqmuYCkym9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by SJ0PR03MB5534.namprd03.prod.outlook.com (2603:10b6:a03:279::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Mon, 16 Mar
 2026 12:55:25 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 12:55:25 +0000
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
Thread-Index: AQHcstE/ku+BrpeHyk25hycFu2yGm7WuKSYAgALtptCAAAuKgA==
Date: Mon, 16 Mar 2026 12:55:24 +0000
Message-ID:
 <LV9PR03MB841401227F21E83950C0DDA7F740A@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260313-ad4692-multichannel-sar-adc-driver-v3-0-b4d14d81a181@analog.com>
 <20260313-ad4692-multichannel-sar-adc-driver-v3-1-b4d14d81a181@analog.com>
 <a1824f39-3925-4e94-ac98-52dcdfbaa0d2@baylibre.com>
 <LV9PR03MB84149CBDC5DD03EDAF554136F740A@LV9PR03MB8414.namprd03.prod.outlook.com>
In-Reply-To:
 <LV9PR03MB84149CBDC5DD03EDAF554136F740A@LV9PR03MB8414.namprd03.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|SJ0PR03MB5534:EE_
x-ms-office365-filtering-correlation-id: 853a85f7-091d-420e-158b-08de835b4a9a
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 GgtbojvPBjUR648Na4fCrcLX/WHchRpjPjXKARKRUuaTotl5EOMRxwPT0qRxmMv6Q95cnhM+ckTUNGLtzT+3sXsFAJ7YjhCCzau+r9UqTr3vNImljXm7OAg3nmHI7LrJWwkb2++6j5yi2BnYgxe5dhBxelFymsa52xC9sW0oVfWHbZ7ZOdqUAUbeDtPspGc2NvRqVFwh8oIYU6z9B9Mlyn3yobr55jwpqIv5kKN5G0JFZwikG1gRGTuRmhrE+enXb7V5DeAPmxdH96RFOhUC1QzjSuVv0y14Wj7I7CMC0kroEYxGEVSy5kHd2ZX4YOQEa7OpAZcqfh5jTDJXBwCoxHHJAsENjMsWTdUseHDRFuwmO4QMwyI+hNHJQpcXKImzCy5yzti/P2GIByiZeJfpakv8+F9eDhw4z8HYMPL47zmC745GGa1B+hNW53N0DeJobXFWng0I5+r5F8M3iJH5JmQ0JiQNJmQ63d8PS8xnw6EomSEkkyNOQNK8VmvVH/FKIegphryPJoEeMi2aLWiJW/N6mH12vFc5wCie2pnrfygtGo3m4a9bTg+5uPgt0MHlAME9x+bUAxaM+JA8LKXIs6jAEUo5V+G6CNcGk9c1sI0lAzL+7WjzUSdxDIttT6GPefbDJXZyndjJRXQpQ5FDWBfKwrMB9MhRO4ba/9hO9cEF+SJrFrdlQX40/mNxXGqNQdj2cXTsO/D3ehD1zO/wwL8cPygFNj+d5R64OvlPcH6NMU/uaDVIU1ooz8d8zuYTLRPIDu2J7pHHnR7mDCMgXG1NEoNF3iCP8CrBfibUY6IibxuLLhLN+MPSWRH/0yGZ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?b2ZxYjF4SkFtcTFBQ1dhK05WMUg3S0JJbnhBWEFuM2F1NmhHdzlCeGFTdFBu?=
 =?utf-8?B?SVpHaXhpWVJFYU80REFGWjRpR0RpZm0wNWhnVWRCMmZKK0QzWVhGNkg4Nklj?=
 =?utf-8?B?bnpKaHQ3U3VPYU5rRUE2VllXWlJOV0tBQmJaQWprNnMwNTZnT3RrTFRLUTVW?=
 =?utf-8?B?eGRhVG5UdkpCTWFlR2hGMDc2WWdISjFBbHVjVGVMU0FsQWdacGZ3MWUzRHZv?=
 =?utf-8?B?RDIxNmt3c3NwcVZJQ21SckJHRDVVV2VLNGNsTmJ1OXZselYxYmxua2NxdzdJ?=
 =?utf-8?B?U1dNSnN6OTI5Wm4xWGVFamZIS1pZSTdicHQydHovUEdkSHpUTnlwWEE1Mjdj?=
 =?utf-8?B?N09DUHBIWXFPcnR5bFJCMGN5aHdSWWhSanRIYmJDZVJodElMMzNYSURST0J5?=
 =?utf-8?B?VXRGc2kzYVZHbXl1RTlNdE5YUzNNaDdvTEJSa1kxdUJ4ZTdNSWFkWTQ2RFZH?=
 =?utf-8?B?RXlXR21kWVZVTlJqTkpseEVuZVd1M2trVEpNZkFiazQ4UHkzem5hTHZYc0ZZ?=
 =?utf-8?B?ZHhqcm1JQUpOT2N4UVZyMFFOZU55TlN5ZWUxQkM3NWJaVzhjaXBJMnp4UzJ1?=
 =?utf-8?B?Ym1ON2J4S3RuNU9FQ1FBZmlOWVhWL2hlR1BIWWhxVkRvK0lzZW51OHRJT3NP?=
 =?utf-8?B?cHBoTkxrNGdKRDJFOGxhT09Sb0NrU3d5WXNTd3ZDV3VqSmo1VFZGdlZCYjRT?=
 =?utf-8?B?cTFtT05HMEtnZGVzNHhaenRCckt5MW9aeVRYR0E3eUdYd041UkRWS0J0UGxF?=
 =?utf-8?B?bE1pWXVXdi9YSzV4QUNxc2FFaEN2VFQrQUZ1dDlmemYxb2NsV1pzUGNjdEJG?=
 =?utf-8?B?V2NxdmxHR0RSd2k1WEVWbGh5MGtSbmNTaDRTZWp0OER4RnpDc0JhbzZzQW5x?=
 =?utf-8?B?VWVNVTg0NGxDejRVTjNCKzhZRFpYQ0NuRFNldGFoQjlyT1RwYVhjY3E2L0px?=
 =?utf-8?B?bThlVVk0NWFkWXE0S2w4MGVDdGZKeGxHOS9aSkZ6eXRtN0RnSXZFUGxhTjBt?=
 =?utf-8?B?MklhR0pVUS8zTi9PY1BmNDBrbTZBTkp2dUVLeEdPak1DRDNNck52RGtpbm84?=
 =?utf-8?B?Yis4S0NjWHRrTkQvaU1NREx4ZU1HZURXMXcvayt3dEUxeUpCRDBVN2s5Mlp4?=
 =?utf-8?B?a1JRQWhEcklFbVpWNVpkbHFQSG5CMmV0SGtPUS9XR0lPLzhqd1VEQm8vSlhU?=
 =?utf-8?B?RUtCYmJDOHBjdjdlRTU2V1huelZnb1liaWFHK09raTU5SFg3R3FwUnVBclIz?=
 =?utf-8?B?dm5VbTZLV2lRVktSVnhtS0FkMFBUMGFmSS9ESnlINU5HOXltZVlCdXB4VHJJ?=
 =?utf-8?B?c0NRWXRoNlNrOEN0WG1ZZUdiYXhNUnc5Rmd2WHdTUndtV3lzK1VXdFJiYVRY?=
 =?utf-8?B?NXczR1ZNUVcyaHppNXBHU09MMTdNbE1KaTV2T2xFK0J0M3FmY3RIQVcxNlBu?=
 =?utf-8?B?UTBMSk1FODgzeEFjS1p5VkVEUStZbjlqVnFSQ25Odm84bjFiaS85clR6bFFY?=
 =?utf-8?B?dWYzYlBQVDVONy92dVl0bmV6NGRadXo4OHpmNE9WbnZwNVExYXQ2RFVKY3lr?=
 =?utf-8?B?Szd2UGE1TUw4b0RrL1l4U01TRGZCOGhDVWloSmJxSUdOZUNzdTh5d3BZVElP?=
 =?utf-8?B?QnJsRWpYajZpUDhiT3hzaXJBNkRYMHpKdE9GOElkaUF2WmRwYzl4aHg2UnJu?=
 =?utf-8?B?b0J5Z1BiU0FmZG5qS2hqZWUwNC93T1RJUjdING1tYThvdjdwQWFUc0ZyaWI1?=
 =?utf-8?B?aEFZWCtCeFp5WStvbS9TaW5NYmFYdkZwOUlsaVdIa2s0dlAvLzVJajlCbGl2?=
 =?utf-8?B?N2tZTEdOb1VyR09NSmhMN2hXTlhrYW8zeWQxSC9LdThZbUlPZ3JnSVpveG1M?=
 =?utf-8?B?NnZ4cG4xQWhVcHBKaDRsWkU2TFdwaFBjU08vUTlGTVUvRzZ6cnVHdGlSbWxO?=
 =?utf-8?B?RmkybW1qRGlYaFJBbXIwek45ajVWUXpIMFlWdCtYbTRuSlJxdEYwUDd6SElt?=
 =?utf-8?B?Z0xMQ3NpN2I5aXBZTFFXY0xheUtVejZwcEw3OGxuZ3hZeDl0VlpWc0lHVDNU?=
 =?utf-8?B?NHpjTUNnU0wzeGRXVnkxUW15QkVLbktUUzFIZjczUkxBWkJjcjBHY3pjVVJD?=
 =?utf-8?B?dkVXU2xlQzV4WHVDd0ZrVDBBUzI3ellCUHpKOVB3Rm5rQ2pmaUpVQWRmYXpF?=
 =?utf-8?B?TmFsTTFuQVlmdGloeEpYRUpLZmlxY2VGMG1BQllTUnlHUnMrUXEycDFxM0FP?=
 =?utf-8?B?WFNwT00xU1lQdGFUV1hYZFNmKzZOQUMzcVRDUGRJangyc1I5UWluZjZkTng2?=
 =?utf-8?B?aU5uaWl4NFB6eFVlZ2Q1cnhWTW05ZGdoRnBIVXVRV3FRQ042VmJ0dz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	jfw9w5i5YDOgRGxUnRrViZZspYMFvsOix+JTlMObgJZrvl/UvDHjVBFhJYDD0ZMvNCKZFe1dvj1KH6HZZ0vZgUg9UmxAsMEvX2VF6WpLChg8aaUx7EIq+T7ts4eMC5Tkd5SiZLnDrUpwOyqd9sln5i4Z8xDgJUZOwXAqNbzXwMETsg8bX8chndaWwFzR1W4LHYLA6cxfGk1ja9dxP3fsjApA2ZG/HEwawNtUPs6U2h2MjGwYqRr3MvKMqjyDk/ao4ter/oA9SPw5RQta5X4xAEcutaP7PINg0Dmz2nfZqSZokthtAWjHxOP0Q+t2Zn1OWDlmgvM0LudVYQ1FJerrjw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 853a85f7-091d-420e-158b-08de835b4a9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2026 12:55:24.9970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rF1pqzqUD7YKDR2F1ncCungJb1ZzIMF5AtmT0yiludIqR49kZPwQzGiQ2xzLMeEgycOeJokZ4E7mdDZTw0P1/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5534
X-Authority-Analysis: v=2.4 cv=etTSD4pX c=1 sm=1 tr=0 ts=69b7fdc0 cx=c_pps
 a=xtX6lszn+wSwJ/mzueWfcw==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=_jAD5XSDOtq9-5Nde2OG:22 a=2oC_eLge1JEu3cAZE2AA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ehYkcc9aIuVMNpNwhUzGSwH-A0gCdXfj
X-Proofpoint-ORIG-GUID: ehYkcc9aIuVMNpNwhUzGSwH-A0gCdXfj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA5NyBTYWx0ZWRfXx6bHd7XNmRYZ
 xnF+O96TnhDLoQ8zguyJPE6ITLUikiTVRxTrRTpfwKb6SIfSeX0OuykyB5h+UYC1nt00DLT+CmE
 r8WL+LlsFvVhAXoe9N3dOHeMdZkPCtAJCkIPK3HHy39PDbB7q5bfA9Np0r97tnUibq5EWLCxr0E
 dLWAs+b5mrCqN9ixYxXWoyhc5VAj8WdhWM5iI6FHrcRUxQHoA+eU1gJZDQXDGmqcI7dc6e4wdK2
 C/XRe422BSRtu8mXh9weDS5KslOF0bF0D+dA9NDU8IjKeIlggjYxcwt1a3357hZ8sNfc+LJBXuB
 5LGqf4G3wHnJjbPFZXowzSO8rg9opwRAYzpApIcS1FXcV3ZMWZwDIo5ZKdiP82nqKMBCUk3Cor8
 WzWhyET4SrZ/ufABbdR3sp/zR4sCckUqmrEJriB6EnNc31gfNfztMr568AJzEi4JlQThNLdgDAV
 ADW0kUTwOCfMqZqcVMg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160097
X-Spamd-Result: default: False [2.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-8268-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[baylibre.com,metafoo.de,analog.com,kernel.org,gmail.com,pengutronix.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[analog.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,LV9PR03MB8414.namprd03.prod.outlook.com:mid];
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
X-Rspamd-Queue-Id: 0DD13299B3F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU2FiYXUsIFJhZHUgYm9n
ZGFuDQo+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMTYsIDIwMjYgMjozOSBQTQ0KDQouLi4NCg0KPiA+
ID4gKw0KPiA+ID4gKyAgY2xvY2tzOg0KPiA+ID4gKyAgICBkZXNjcmlwdGlvbjogUmVmZXJlbmNl
IGNsb2NrIGZvciBQV00gdGltaW5nIGluIENOViBDbG9jayBNb2RlLg0KPiA+ID4gKyAgICBtYXhJ
dGVtczogMQ0KPiA+DQo+ID4gSSBmZWVsIGxpa2UgSSBhc2tlZCB0aGlzIGFscmVhZHksIGJ1dCB3
aGljaCBwaW4gaXMgdGhpcyBjbG9jayBjb25uZWN0ZWQgdG8/DQo+ID4gSXQgc291bmRzIGxpa2Ug
aXQgaXMgdGhlIGNsb2NrIGZvciB0aGUgUFdNLCBub3QgdGhlIEFEQy4gU28gaXQgZG9lcyBub3Qg
YmVsb25nDQo+ID4gaGVyZS4NCj4gPg0KPiANCj4gVGhlIHBpbiBpcyBjb25uZWN0ZWQgdG8gdGhl
IENOViBwaW4gb2YgdGhlIEFEQywgd2hpY2ggaW4gQ05WIENsb2NrIE1vZGUNCj4gcmVwbGFjZXMg
dGhlIGludGVybmFsIG9zY2lsbGF0b3IuDQo+IA0KDQpNeSBiYWQgaGVyZSwgeW91IHdlcmUgcmVm
ZXJyaW5nIHRvIHRoZSBjbG9jaywgbm90IHRoZSBQV00sIHRoZXJlZm9yZSB5b3UNCmFyZSByaWdo
dCwgdGhpcyBzaG91bGQgYmUgcmVtb3ZlZCBmcm9tIGhlcmUuDQoNCj4gPiA+ICsNCj4gPiA+ICsg
IHB3bXM6DQoNCg==

