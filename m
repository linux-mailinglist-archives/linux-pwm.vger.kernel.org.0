Return-Path: <linux-pwm+bounces-8847-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QM8cLhnF/WmwiwAAu9opvQ
	(envelope-from <linux-pwm+bounces-8847-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Fri, 08 May 2026 13:12:25 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A97F4F5875
	for <lists+linux-pwm@lfdr.de>; Fri, 08 May 2026 13:12:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CDE7B3019D0B
	for <lists+linux-pwm@lfdr.de>; Fri,  8 May 2026 11:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C870235FF57;
	Fri,  8 May 2026 11:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="DE7+aBkU"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A3A3264D2;
	Fri,  8 May 2026 11:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778238743; cv=fail; b=MGzPimKrRemtA40HutMTg65y1Flx4ig6ET6RQtIWyAryptkEw8bShNKy8Y1Gtt/FHkPRLq/jCACKM7yEYtO/4X/HgcdkhL/0ml+io+gs41mr9w/BUWXPVtQKKXS2THfmM8/aQym8vPiqlynAGQwu7RAKnYbX3XyntGvC+PkMbTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778238743; c=relaxed/simple;
	bh=7u/6a7khQPDd893TCUaHFt1/ZJBZQhT/QH2fDwarH1E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ojd6BSjd5+UKUULkT/M7Mag2pgBFxjUPp/0+NI5qgL7ZgxJeVNfUdbHZorWJfuiV9Q8mjEhLnfrg6jFDl1pHgIuUrYjG5OeAswEg0cVVwmXmH6+2x6RWxhnVUlrbwHpYEnHcJus7KQPQtWGzec5lm6jCuVOWa6Vxwk+UnZZxnus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=DE7+aBkU; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6488fjY91362963;
	Fri, 8 May 2026 07:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=7u/6a
	7khQPDd893TCUaHFt1/ZJBZQhT/QH2fDwarH1E=; b=DE7+aBkUjCYR96U3/t0cW
	+cMWVhiaaLnDYRzu7dccs8ah3MN29S89D5o4Abq2f521tuqtspcJy6CJeNeDM18s
	o3Rwyq1CmItnV0SPvl4GvUdIdhsfnrvV52t0t/s6jLgvJvrCVyQgMyijzVQh1067
	nxQS4nSGjvK6CSilvmozel3WD7hIgWfQ/RqH6W9PyxJi+e5zrlI8+D1lE+rp3Dan
	kAaTDa2EkNJ+kYgVyUnZEwA+0TcyBwGBZyPC01vMdzdf/MUBS18DDyMirI1be3wY
	8Zsbhqh6E8yjYq2qEQQKLy8YdBNTyzhmiaH5vyBlGoUwdJv0ZMQn7OPS5Bu1Xvq6
	A==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013042.outbound.protection.outlook.com [40.93.196.42])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4e16y39s6x-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 07:11:47 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVeS+b2BMIpF4uqgFDpbmEEYMMoiWMXZp1aiU+SF/qlvJ0ociV1TkCPVLyhGNY1xPynbFp5KhBSTf2BvKBCEHRL5E3Hw3vK4PkMmI+micjLq88vkRaYkM991/jzU/PiC5Me0+ly0DEU6yqvv10eucjjQQ9Tg3RWuSgPd7z4hvy287EwVDCBrNHgPHv77YUZ6WL/fPHOfMGYlOBp9RkqILvu2J+QH/HlHsEb4urkzkp+82pMoP5BGq1bY6FfCwnHlbGJoVFXCfOUPwwd/VioYgWWmzK5Rll9cOPTDhFcoqJfWeVGx11dKFfeVSOQCha0u3Yx0+IkDnAZw0YOpDKfjrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7u/6a7khQPDd893TCUaHFt1/ZJBZQhT/QH2fDwarH1E=;
 b=rHn2DXyQk0FEkHKRtgRlOmFYvbYm3ObAtY/bouEoSDlyu+4gIArE2mPpN9goNbCNlWvO9KG27DI8I80jeFEUq74ocD8RVLMPT1fCfOilCpy3PUmk0/Ejs7Lb4yqWnaz8j6JchQbTNTdQyoiLo6ngwdvwuR+v+WAOuWMdvS1baB6yDRvdqSiBEgtMsRH2I+pyeXSN/xgSOjDSvhqBu+XbV37xR3mbYtA6BpXmzp+SdBIIgRjSSECFQ/0kkzgRMGrLTd2Pr+dRNP9z+fXMlZIQgO304Ltu4Id8DNo8LEBkrQrPedBUMsCzPTunZxqTUhnrmDiJl2OXUDh93hedRKaD2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by CH2PR03MB5335.namprd03.prod.outlook.com (2603:10b6:610:91::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.19; Fri, 8 May
 2026 11:11:44 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9891.008; Fri, 8 May 2026
 11:11:44 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        "Sa,
 Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?=
	<ukleinek@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
	<broonie@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski
	<brgl@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jonathan Corbet
	<corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v9 4/6] iio: adc: ad4691: add SPI offload support
Thread-Topic: [PATCH v9 4/6] iio: adc: ad4691: add SPI offload support
Thread-Index: AQHc2Ip7GFfgCljdvUysP75/UKS6EbYCetZwgAA7j4CAAU6mgA==
Date: Fri, 8 May 2026 11:11:44 +0000
Message-ID:
 <LV9PR03MB8414B6A36417AEE669021828F73D2@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260430-ad4692-multichannel-sar-adc-driver-v9-0-33e439e4fb87@analog.com>
	<20260430-ad4692-multichannel-sar-adc-driver-v9-4-33e439e4fb87@analog.com>
	<LV9PR03MB8414E7E034F79900A6595750F73C2@LV9PR03MB8414.namprd03.prod.outlook.com>
 <20260507161111.555bba75@jic23-huawei>
In-Reply-To: <20260507161111.555bba75@jic23-huawei>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|CH2PR03MB5335:EE_
x-ms-office365-filtering-correlation-id: 2ce87519-9497-4c00-4a0f-08deacf296a8
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 tsVYEBQ77IBX6PJw2XsVvlUxehLs+uVYSOnBj0lhOwc9xf1DAcWnKsmw6nhmjImkLxjTz5WmUqUjmLXSrMLHAH2HRrDA4htp5Bt7e+iHsuW/EBf6G9xFLSNepa3sGAmimg/zvOzeDJagJLlT5A1A58ys+3l/BOhV2xEGm+dTcczsdzU2IRmXNt1Zd5Zo5rjreI0NdqMSWsF5220LHLrcQHd6paESIsa/o/limbY4pNZVHfeLHfNFb2VnwWZ8NwzyNYC0zEKibJIOJVEUTlpd7W14jjXRAF1hFKISlk8D7TbLiZ2Jl8sk9bj2mXUTuA2PkTcSDa4XXTqC1YBtUISOfDwyWqUctffjrCHDfoIFR29c8FWB1N9Dp2181tnZFHnGB2zDQ3UrMNnFC5L15hOOLgcZe2vRxkiaeVs49HvDH6thX4ZYDUhgAQg1DFtET5ZtnHUesKwi9Thl8EuLGst11IA9IW/ixm5idmRBpO6Y2EWXRjdEtr+xBSTXL51Vr3fu1bRmA2puS0a7iIzWRet+vKIbF7prgdAnmn2i7h9t0AChfTiQu/jYgytcAfkndfhkUjhe/0XReaGb6VyiNFiDeQHB/ingfU6Bg3NpsT8L0BTi2Yp/RRuOHumNDCceVugHTGUc1b2bp1ouvgRPNqHGUx5ziILLS2Hnwh/VGvmv2GJoRS32+V9TC/COCNefvBwGuFeA7xsCTqKbdpWIq4177Yguzrpgc4mPvCfm9JbJjQoxOvcgheOI97QLfResvG6+
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vm9uZ1Nzd0g0NndWRlZkM3FSdGVJV3hrSHVlaWxURWVKTU9RaTRCQk9qUEVr?=
 =?utf-8?B?aTdneVYrVS91WjNQcktrV3VBOFVWRUZqMTRnRUdsZmd3OFZPSlRJVDYvanI0?=
 =?utf-8?B?di85SkFGVXlNc2RIYmw3akxacGU5U0RtN3JrOVZXWE5KT0x0MFoyektKVEk1?=
 =?utf-8?B?SHNWb1R0NHM5YjlhekZsdG5oYjM0WXZwRVFhKzBHNGRSVFo5ZlR2SlFyakk0?=
 =?utf-8?B?NGU1NXVjaHFlWkJLNWNuQUlURlNKUVZEZFowQjB4QW1td0YzZGtPS25HZ3cy?=
 =?utf-8?B?dDlnME1iTWo1OGIzNm9tc0pBaFNjVTY4Sk9Oa0s1Uk5YTTExcXJoVWZiT25N?=
 =?utf-8?B?czVVQUgraldqL0NGdUlEMkxzSW1RMXlFMUdsZkRoeisyUUdPdHFzZDFBMlZs?=
 =?utf-8?B?MUVxWlBlWWNNL1poUGhONFlwS2pDdzMrOEg2dkJ4N3BpdXpqVmN2eVJvL2hK?=
 =?utf-8?B?M0NSY1pTWDNjWW9PY2JsQTUxQnRZNVlKRTFWek15dmJnTUtRczdjemxWdXA0?=
 =?utf-8?B?MUVMVkRiRnNEZ3dyWVlNY1U1WGtNUmE4S1NJNWUvRXJjQXgzZ3h3blV1dHlo?=
 =?utf-8?B?cU8rSEJVRTBvcFZjeHJGUVRJVmpzUW9JeTVHVVZ2VVpIMjBoeFBjV1RRdlhJ?=
 =?utf-8?B?ZkIzR2txbnd6UHdhdW1JQktDMkZONmFTUkkvWHVudzVmK1d5Z2VMRDdvQXNF?=
 =?utf-8?B?aGYvL0haVUw4NEt5V1JlcUh5ZS9GZ1RpcFVRS0phNDZ2K2ZHWmUvQnY2RHBn?=
 =?utf-8?B?Sk1DOHVnYXMyL211ajJzL3duck5ZR0FUZTN2RUlWa08zVE5TSlBtbnRHa1FY?=
 =?utf-8?B?N2V6OXlXaURmQWZUZGRKM0NnOUl2cHhEa3V4cndrMXJ1dFB3VVJUc3BMZHZn?=
 =?utf-8?B?alhVSzUvNlJBSElTUW1HT0hIZWp6eFpJcmRDZTcrSUgrZlNGWW42YSt0M1Ev?=
 =?utf-8?B?NkM2MnByRjF3S1A0QXZPOEJCa1dHVGlFR2drNXFDblBoMWgyZHN2clhLUEVH?=
 =?utf-8?B?U1hDUGhIYW1rVHU2NGxLQU5FVUlDbC9VWG1LZWtZT3VaVU8zQVNXem1VZXk3?=
 =?utf-8?B?NzBieHR0emgzQ3hMMDJZNUlIWUxpb2h0UzIwNmF1L1B1VWJhVVF2MnV2b2pF?=
 =?utf-8?B?UTgwNTVIM1prT1ozTDB5eW90ei9iSWpxcnozNEkrN1cyOGRTTjJqL1RtOVZy?=
 =?utf-8?B?dHEwZzk4U3dzVGNKZjk4aSt4WnZhOGZvbHB1NVdqZ1MvQUtjN2Voc2V6MVBD?=
 =?utf-8?B?cHVtcGNHM2ZmenVldUhYNzlIMlpIVU1zQVJzU2R6ait4d3NQalhJemN2Mi9W?=
 =?utf-8?B?M3BTY3FNcitJdEVoYW51ZHYwek9RMmpma3NWbnlJTkJEekhOb1RiNS9idXlQ?=
 =?utf-8?B?cWlSbjZjY1NGWllMR2Z3NGE0SjJuNTV0ejdNcnF0Y0luM2FJWmJCR1dLSUhh?=
 =?utf-8?B?MFNlUFp5K1F5RUZGRUVFQUY4WE1RVmtubS9tTFFnbnVSYk01b0E3bHBPcGRJ?=
 =?utf-8?B?cXoxYm4wY0JxbUlDd3FTNXJ6c1F2NFZjOHNUZVJMc2dkNkhLejVXVUErenp3?=
 =?utf-8?B?d2pwVkUyNGpEYkJBYnFUVTllWmJzMy8rK2YyYStyRDVSWFhIZ1F4c3RMNDFL?=
 =?utf-8?B?aGVYRFNYYkRFUkR0QzFmaHJVcnVZdDFjSitpc1d6ZGJmbWtuTUFCUm43UFZp?=
 =?utf-8?B?M0tGSzR4OHNaT2x0d0RRQ29PTEhJLzFyY1p0VzZHMzg3VFVJM043MEVwT29i?=
 =?utf-8?B?ZWVVVUJEZnkvMVp1WStZSGZJakM0KzNjRXFGYmpTV3VyM1J2YlRURGRpeVhT?=
 =?utf-8?B?aWpxVzNFWW1VVHVKVlk2STZoZ2tORkc2aUhaU2NSNThyTmVkOWcrUkpuN1dJ?=
 =?utf-8?B?RnFqdVF2SUxQV2txQUZ0aDU4a3JVci90K2RSS0duMCs2L1l0Y3IvMnZKa3Qw?=
 =?utf-8?B?ZDJ4ZEZJTWd5OVJ4WWR6bG9jQUU5ZGlYRFV4aU9iYms0TStaM2paZThLY0pH?=
 =?utf-8?B?MHVZS2kwd1BGeENmQlZxQVRXdTNjN3VPMnZXTWxVRHFzWXRqakpxRGpmWVNJ?=
 =?utf-8?B?aGNFdEVvZ3k3cHpya0RQUHJNeFZLQjVKUHpXQ2FpTnVQeDFmeHNtYy83VmtR?=
 =?utf-8?B?SC9EaFVkWU1RME94QWZCSHhVMnNRZ1VhYWlkK29hYUMrSlpZc3FTNmRXQTdr?=
 =?utf-8?B?SFNUbjBQV0lTT0hKbk9EQ3VqNXFOYmtqMi83QklKdWVKcmxmNkE5ZTlYc3FY?=
 =?utf-8?B?NTZGOWlRdHdpTnNOa1ZHckU2TElzQWRUK09qOEpJemRpQkVWVU45dVJnaFlN?=
 =?utf-8?B?QnlFUjF6ejZTZnZzQUZhS3oybVFPSVVsS2xIZ2tHVVdpSTYzTHBZZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	WDlQtZ3+3eG6KEBhTWGViXLnRLrKOUbIMbehN4MrWkReev/ahGrItZLY9rtM1fWjb/0qXswwnjY4XgqKm34cFLHx2QoHFBHqU+vQjQCteSfaXmgHn0/LXMi6VIW+MdTjOkb4O1/JpFWyXW10evdxYtYyiVqxVblBlrRnrME5peOaUfSgvlpoZCwot6iICVXktKMMLB9LfSbWXdzaTjlLxfQLdi/IctgXyWAZ8ADc03mlNq7+jypCdUWXvCWqEZWHjFR1GYp0xzl7NVPau2KkuMhGUMwboXQtiNa3IyrBzQNNkB1kKFL3a+rxyfjBygfP5Y8NozTGPjQ/kFYMmwJCTw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ce87519-9497-4c00-4a0f-08deacf296a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 11:11:44.2314
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Lh2uW72Gd8m9YP3NgwccD46G6q0GAAX+8yaeOEm5gBaRUTTZcx/VA2WgNR8OiZjLlE4K/4mTw/y7lI51aLj8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5335
X-Authority-Analysis: v=2.4 cv=FJArAeos c=1 sm=1 tr=0 ts=69fdc4f3 cx=c_pps
 a=BmBYDrMhH73hh332m6kGpQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=iZSIUCweCk2Oy3QsdGPA:22 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8
 a=pGLkceISAAAA:8 a=07d9gI8wAAAA:8 a=ag1SF4gXAAAA:8 a=BcUPVCjYFdIBxk_mAWIA:9
 a=QEXdDO2ut3YA:10 a=IawgGOuG5U0WyFbmm1f5:22 a=e2CUPOnPG4QKp8I52DXD:22
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-ORIG-GUID: FjTM3vvc6VPw49J4-7mWB_G0ckIvg0FF
X-Proofpoint-GUID: FjTM3vvc6VPw49J4-7mWB_G0ckIvg0FF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDExNSBTYWx0ZWRfX822CugG5qcOs
 BP6HoZQ/dMFtrEpvfhfraFF7vYeO0mQPaZjY2uQ6tK5sKudLZbc0vI9rMHCSnZwKVGTfZA+uayF
 wHAmyGi4os8ZbUDn6wIwlutJ6YmjAz3mAlWd9LVO+lY+OofivfS2LIhKf2kBztr1s1rWBmHRpqg
 c8dNrExYhRbjFvBX93cK/qAC3CcoyHLM1LhMiC9jP/EsRZhZIyCWZN8EtCz6emlcfR5fb2X+21g
 epsepEm9Ou78I4I7YI/dlhNYxuYRLfn9g0UynHciTfewukRbHC9o5ROh2g9o8WPvKXQmAqZs/WX
 LTwcZUUXMDla50ameSOsnE6Gse3syG1ocoXE92KbcfTEz6f03uNADcs6x9adpo2WHWj/4NHrIG3
 9Zmk+1CvthnQb86p/mhqjgY0VoInKjMwesZoDW1Lgc0uyvm0ZXEPvxVpgI5p7uf+KhXXYq+gamA
 Lt0nPsG6pX9mjcevR1Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080115
X-Rspamd-Queue-Id: 9A97F4F5875
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-8847-lists,linux-pwm=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,baylibre.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxq
aWMyM0BrZXJuZWwub3JnPg0KPiBTZW50OiBUaHVyc2RheSwgTWF5IDcsIDIwMjYgNjoxMSBQTQ0K
PiBUbzogU2FiYXUsIFJhZHUgYm9nZGFuIDxSYWR1LlNhYmF1QGFuYWxvZy5jb20+DQo+IENjOiBM
YXJzLVBldGVyIENsYXVzZW4gPGxhcnNAbWV0YWZvby5kZT47IEhlbm5lcmljaCwgTWljaGFlbA0K
PiA8TWljaGFlbC5IZW5uZXJpY2hAYW5hbG9nLmNvbT47IERhdmlkIExlY2huZXIgPGRsZWNobmVy
QGJheWxpYnJlLmNvbT47DQo+IFNhLCBOdW5vIDxOdW5vLlNhQGFuYWxvZy5jb20+OyBBbmR5IFNo
ZXZjaGVua28gPGFuZHlAa2VybmVsLm9yZz47DQo+IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5v
cmc+OyBLcnp5c3p0b2YgS296bG93c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+Ow0KPiBDb25vciBE
b29sZXkgPGNvbm9yK2R0QGtlcm5lbC5vcmc+OyBVd2UgS2xlaW5lLUvDtm5pZw0KPiA8dWtsZWlu
ZWtAa2VybmVsLm9yZz47IExpYW0gR2lyZHdvb2QgPGxnaXJkd29vZEBnbWFpbC5jb20+OyBNYXJr
IEJyb3duDQo+IDxicm9vbmllQGtlcm5lbC5vcmc+OyBMaW51cyBXYWxsZWlqIDxsaW51c3dAa2Vy
bmVsLm9yZz47IEJhcnRvc3oNCj4gR29sYXN6ZXdza2kgPGJyZ2xAa2VybmVsLm9yZz47IFBoaWxp
cHAgWmFiZWwgPHAuemFiZWxAcGVuZ3V0cm9uaXguZGU+Ow0KPiBKb25hdGhhbiBDb3JiZXQgPGNv
cmJldEBsd24ubmV0PjsgU2h1YWggS2hhbg0KPiA8c2toYW5AbGludXhmb3VuZGF0aW9uLm9yZz47
IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gcHdtQHZnZXIua2VybmVs
Lm9yZzsgbGludXgtZ3Bpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5v
cmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2OSA0LzZdIGlpbzogYWRjOiBhZDQ2OTE6IGFkZCBT
UEkgb2ZmbG9hZCBzdXBwb3J0DQo+IA0KPiANCj4gPiA+ICsJCS8qIFRYOiBhZGRyZXNzIHBoYXNl
LCBDUyBzdGF5cyBhc3NlcnRlZCBpbnRvIGRhdGEgcGhhc2UgKi8NCj4gPiA+ICsJCXN0LT5zY2Fu
X3hmZXJzWzIgKiBrXS50eF9idWYgPSBvZmZsb2FkLT50eF9jbWRba107DQo+ID4gPiArCQlzdC0+
c2Nhbl94ZmVyc1syICoga10ubGVuID0gc2l6ZW9mKG9mZmxvYWQtPnR4X2NtZFtrXSk7DQo+ID4g
PiArCQlzdC0+c2Nhbl94ZmVyc1syICoga10uYml0c19wZXJfd29yZCA9IGJwdzsNCj4gPg0KPiA+
ICJXaGVuIGJpdHNfcGVyX3dvcmQgaXMgZ3JlYXRlciB0aGFuIDggKGxpa2UgYnB3ID0gMTYgaGVy
ZSksIHRoZSBTUEkNCj4gZnJhbWV3b3JrDQo+ID4gdHJlYXRzIHR4X2J1ZiBhcyBhbiBhcnJheSBv
ZiBuYXRpdmUgMTYtYml0IHdvcmRzLg0KPiA+IE9uIGxpdHRsZS1lbmRpYW4gYXJjaGl0ZWN0dXJl
cywgdGhlIGNvbnRyb2xsZXIgd2lsbCBieXRlLXN3YXAgdGhlIGRhdGEgYmVmb3JlDQo+ID4gdHJh
bnNtaXR0aW5nIGl0LiBXaWxsIHVzaW5nIGEgdTggYXJyYXkgYW5kIHB1dF91bmFsaWduZWRfYmUx
NigpIHJlc3VsdCBpbiB0aGUNCj4gPiBjb21tYW5kIGJ5dGVzIGJlaW5nIHJldmVyc2VkIG9uIHRo
ZSB3aXJlPyINCj4gPg0KPiA+IFN3aXRjaGVkIHRvIGNwdV90b19iZTE2KCkgYXNzaWduZWQgZGly
ZWN0bHkgaW50byBfX2JlMTYgc2Nhbl90eFtdLA0KPiA+IG1hdGNoaW5nIHRoZSBub24tb2ZmbG9h
ZCBwYXRoLiBUaGlzIG1ha2VzIHRoZSBpbnRlbmRlZCB3aXJlIGZvcm1hdA0KPiA+IHNlbGYtZXZp
ZGVudCBhbmQgc2lkZXN0ZXBzIHRoZSBieXRlLW9yZGVyaW5nIHF1ZXN0aW9uIGVudGlyZWx5Lg0K
PiANCj4gVGhpcyBjb25mdXNlcyBtZSBhIGJpdCBiZWNhdXNlIHRoZSBTUEkgY29udHJvbGxlciBz
aG91bGQgd29yayB3aXRoDQo+IG5hdGl2ZSBlbmRpYW4gYW5kIGZyb20gdGhhdCBnZW5lcmF0ZSB0
aGUgZXhwZWN0ZWQgYmlnIGVuZGlhbiBvbiB0aGUgd2lyZS4NCj4gDQo+IFNvIG9uIGEgbGl0dGxl
IGVuZGlhbiBob3N0IGJ5dGUgb3JkZXIgaW4gYWRkcmVzcyBzcGFjZSBpcyBMSCBidXQgaXQgd2ls
bA0KPiB3cml0ZSB0b3AgYml0IG9mIEggZmlyc3QgdGh1cyB0aGUgQURDIGNoYW5uZWwgYWRkcmVz
cyBuZWVkcyB0byBiZSBpbiB0aGUNCj4gc2Vjb25kIGJ5dGUuDQo+IE9uIGEgYmlnIGVuZGlhbiBo
b3N0IGRlc3BpdGUgdGhlIG9yZGVyaW5nIGluIG1lbW9yeSBiZWluZyBITCwgdGhlIHRvcA0KPiBi
aXQgb2YgSCBpcyBzdGlsbCB3cml0dGVuIGZpcnN0IHRodXMgaW4gbmVlZHMgdG8gYmUgaW4gdGhl
IGZpcnN0IGJ5dGUuDQo+IA0KPiANCj4gSWYgeW91IHVzaW5nIGNwdV90b19iZTE2KCkgdG8gYXNz
aWduIGEgMTYgYml0IHZhbHVlIHN3YXBwaW5nIG9ubHkgb24gbGl0dGxlDQo+IGVuZGlhbg0KPiBh
bmQgc3RhcnQgd2l0aCB0aGUgY21kIGluIEwgb24gbGl0dGxlIGVuZGlhbiB5b3UnbGwgZW5kIHVw
IHdpdGggTEggc3dhcHBlZCB0bw0KPiBITCBhbmQgb24gYmlnIGVuZGlhbiBITCBidXQgdGhlIGxp
dHRsZSBlbmRpYW4gU1BJIGNvbnRyb2xsZXIgc2hvdWxkIHRoZW4gc3dhcA0KPiBpdCBhZ2FpbiBz
ZW5kaW5nIHdoYXQgaXQgdGhpbmtzIGlzIHRoZSBoaWdoIGJ5dGUgZmlyc3QgKEwpIHdoZXJlYXMg
dGhlIGJpZyBlbmRpYW4NCj4gc3lzdGVtIHdpbGwgc2VuZCBILg0KPiANCj4gVXBzaG90LiBJIHRo
aW5rIHRoZSBmaWVsZCBzaG91bGQgYmUgbmF0aXZlIGVuZGlhbi4gSWYgYSBieXRlIHN3YXAgaXMg
bmVlZGVkDQo+IGl0IHNob3VsZCBiZSB1bmNvbmRpdGlvbmFsIGFuZCBub3QgcmVseSBvbiBlbmRp
YW5uZXNzIG9mIHRoZSBob3N0Lg0KPiANCg0KQ29ycmVjdC4gV2l0aCBiaXRzX3Blcl93b3JkPTE2
IHRoZSBTUEkgY29udHJvbGxlciByZWFkcyB0eF9idWYgYXMgYSBuYXRpdmUNCjE2LWJpdCB3b3Jk
LiBjcHVfdG9fYmUxNigpIHN0b3JlcyBCRSBieXRlcywgYnV0IG9uIGFuIExFIGhvc3QgdGhvc2Ug
Ynl0ZXMgYXJlDQpyZWFkIGJhY2sgYXMgYSBkaWZmZXJlbnQgbmF0aXZlIGludGVnZXIsIHNlbmRp
bmcgdGhlIHdyb25nIGJ5dGUgZmlyc3QuDQoNCnNjYW5fdHggaXMgZGVjbGFyZWQgYXMgdTE2LiBC
b3RoIG9mZmxvYWQgcGF0aHMgc3RvcmUgdGhlIGV4YWN0IHdpcmUgdmFsdWUgYXMgYQ0KcGxhaW4g
bmF0aXZlIHUxNiDigJQgbm8gZW5kaWFubmVzcyBtYWNyby4gTmF0aXZlIHN0b3JhZ2UgaXMgc2Vs
Zi1jb25zaXN0ZW50Og0Kc3RvcmUgWCwgcmVhZCBiYWNrIFgsIFNQSSBzaGlmdHMgWCBvdXQgTVNC
LWZpcnN0IOKGkiBjb3JyZWN0IHdpcmUgYnl0ZXMgb24gYW55DQpob3N0LiBUcmFjZSBmb3IgQVZH
X0lOKDApID0gMHg4MjAxLCBleHBlY3RlZCB3aXJlIFsweDgyLCAweDAxXToNCg0KICBjcHVfdG9f
YmUxNigweDgyMDEpLCBMRSBob3N0IOKGkiBuYXRpdmUgMHgwMTgyIOKGkiB3aXJlIFsweDAxLCAw
eDgyXSAgKGluY29ycmVjdCkNCiAgKHUxNikweDgyMDEsICAgICAgICAgTEUgaG9zdCDihpIgbmF0
aXZlIDB4ODIwMSDihpIgd2lyZSBbMHg4MiwgMHgwMV0gIChjb3JyZWN0KQ0KICAodTE2KTB4ODIw
MSwgICAgICAgICBCRSBob3N0IOKGkiBuYXRpdmUgMHg4MjAxIOKGkiB3aXJlIFsweDgyLCAweDAx
XSAgKGNvcnJlY3QpDQoNCk1hbnVhbCBvZmZsb2FkOiBUWCBhbmQgUlggYXJlIGZ1bGwtZHVwbGV4
IChzYW1lIGNsb2NrIGN5Y2xlcywgc2hhcmVkIHhmZXIpOg0KDQogICAgc3QtPnNjYW5fdHhba10g
PSAodTE2KShBRDQ2OTFfQURDX0NIQU4oYml0KSA8PCA4KTsNCiAgICAvKiBlLmcuIGNoPTA6IDB4
ODAwMCDihpIgd2lyZSBbMHg4MCwgMHgwMF0gKi8NCg0KQ05WIGJ1cnN0IG9mZmxvYWQ6IFRYIGFu
ZCBSWCBhcmUgc2VwYXJhdGUgeGZlcnMsIGJvdGggdXNlIGJpdHNfcGVyX3dvcmQ9YnB3Og0KDQog
ICAgc3QtPnNjYW5fdHhba10gPSAweDgwMDAgfCBBRDQ2OTFfQVZHX0lOKGJpdCk7DQogICAgLyog
ZS5nLiBBVkdfSU4oMCk6IDB4ODIwMSDihpIgd2lyZSBbMHg4MiwgMHgwMV0gKi8NCg0KVGhlIHN0
YXRlLXJlc2V0IHRyYW5zZmVyIHVzZXMgYSB1OCBidWZmZXIgd2l0aCBiaXRzX3Blcl93b3JkPTgg
KGRlZmF1bHQpOw0KcHV0X3VuYWxpZ25lZF9iZTE2KCkgd3JpdGVzIGJ5dGVzIGluIG1lbW9yeSBv
cmRlciwgd2hpY2ggU1BJIHNlbmRzIGFzLWlzLg0KDQo=

