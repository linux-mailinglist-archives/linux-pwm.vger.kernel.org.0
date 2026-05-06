Return-Path: <linux-pwm+bounces-8793-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLR2LNEH+2mbVQMAu9opvQ
	(envelope-from <linux-pwm+bounces-8793-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Wed, 06 May 2026 11:20:17 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 995714D8844
	for <lists+linux-pwm@lfdr.de>; Wed, 06 May 2026 11:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B5AA53001383
	for <lists+linux-pwm@lfdr.de>; Wed,  6 May 2026 09:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FAE3DFC6D;
	Wed,  6 May 2026 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="i8xaNt+b"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE66B3D3335;
	Wed,  6 May 2026 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778059095; cv=fail; b=uJ0RxQrgcf+s3y7Q5KgUB2UX8ylr/5M/k6gKDZR0X9dLMVUi+Rwo/MFO07A9ygg7G4qJc5ba8u6NGPMX3Mo9Swm3P7PPGd+yU6/bXlnFWvfWAPB0RCWq/obU+urGjDZ1MLwBEmxqcFE0UhpED10P+7kmMqH0b3a48YcnOV/V4sw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778059095; c=relaxed/simple;
	bh=9uslsVvrrxFz+qJ4VA7M0UqBGU3nyRZ6FJHilUJnxOA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gJDLOPJHGqIdd844yOUYLKEvwSFOi2pjysY7+9L2E4BABlrxnYPmgemenb/af44Ejiadgv9SLEPuGmA6OC8GMZxHUH7GYhE7q/hM3Wt4cm3i+6PagoxsXXODQmo+9CawRvinwvPX2a4W9cdnf2/sII10g4SNFbQIOBi9BdV+yI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=i8xaNt+b; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6463lo8e2378763;
	Wed, 6 May 2026 05:17:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=9usls
	VvrrxFz+qJ4VA7M0UqBGU3nyRZ6FJHilUJnxOA=; b=i8xaNt+biy9WJWBaC2H+9
	XznfvuFXhSR83i/jveIeQTOVKxfHopemP2/SC4Z62Vb+qWfrLA4P5m2NqfhUwSj0
	iBo+3TK2WOIm4q522UJcLKhGATMgT+gfXJjSwd5ZVtr5HSovx4luh8C9sow6Pr2R
	15jQU3zm7KndoCH/PD5KrUyVXy2TarWVTgZ1pKgYlP0WMoALPX1gxU3/6NBGeQZb
	nV1tx780MnKCrfhqyHGj0cSmObVghZgUHpVQcErdv3vm00z88NnKMFzuu67tUAee
	61IGopY5fw8lnA4lbTtRkYfuIYiKe7KjZ44tvFcCxjvNcXBW+DQWKT4WsFlLFhDj
	Q==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013007.outbound.protection.outlook.com [40.93.201.7])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4dyx23ru6b-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 05:17:38 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVT8ulzCSR84LF4EQETQlwCr8a9ykOq3JVEHdcXx1ml/vefEUmfS4AQy9bLNOB3Ssw4f36hpkC6+GluXs+9SJZBvdtZVkAueoSM9T6Mg0qOZkZD/6suRZTNCndos7nm6ydtpW1Vrx2Vw1z+Tdb/eaWBH1tcowpzhTz/CjLHfeUAqcUk4sC7PqiDIxp1zzIFB/7dKTUFBaQYBAeLokWaP/WpZDPPTG/VImX6dCWJ1bYhqxaGP9Fvt851yr1VQa3Lu49vxPByVhFZ/2aj1RQCGwOu4qJ6lkqBm6Slys4DDTpXa/swN7NgaUqeptHGjtf1XmyyAuZEvXykAcQEz+kzlPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9uslsVvrrxFz+qJ4VA7M0UqBGU3nyRZ6FJHilUJnxOA=;
 b=YXc5OC5dlqa9qLj82lpPzYSQJNx1DfwQbTkTqeI75EE2hj3X8ZQUydnqassfrU40KGmU+rRgTYdHN0QFSWnutUQkL12IAkAgrOikCdsLJKo980qsuvWlmPnMQIyCDkMNtx0wZPpdT174BZbn/BnNs5LizZ5cuduhsruQ3VZuibq+ZwTNzEzQ2ZazwZa3BH8nnK3OZSXn4rgwqq0TBDlUnmtiaCdawwbsIRw9sCxteXeQkgwLpao+LgJ2CcQ9Uplw0GX0VgUVl/pf27X6A0mAjk8fX6VlWPrfyaxNZqINQaQ7fTomPkZdnHOxSPDB6SFYQCWofPAoCb9nVKFsRpQH9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by CH8PR03MB8273.namprd03.prod.outlook.com (2603:10b6:610:2bc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 09:17:36 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 09:17:36 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Radu Sabau via B4 Relay
	<devnull+radu.sabau.analog.com@kernel.org>
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
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?=
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
Thread-Index: AQHc2Ip7GFfgCljdvUysP75/UKS6EbX/hcwAgAE55vA=
Date: Wed, 6 May 2026 09:17:35 +0000
Message-ID:
 <LV9PR03MB8414C0CA41D0561D85032461F73F2@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260430-ad4692-multichannel-sar-adc-driver-v9-0-33e439e4fb87@analog.com>
	<20260430-ad4692-multichannel-sar-adc-driver-v9-4-33e439e4fb87@analog.com>
 <20260505152828.61f40411@jic23-huawei>
In-Reply-To: <20260505152828.61f40411@jic23-huawei>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|CH8PR03MB8273:EE_
x-ms-office365-filtering-correlation-id: 1bc95bd6-2bde-4ecb-e29f-08deab504fee
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 8Z1vTQddSo2CyF6EvXxTm7EzMBO05B5uEhlUSBpdrMQEqBc3woynqyIJII7CnqD00gNpxNwJ8ycOgYVhbNolKAx5A+bMXFySduSbVwC8fhLMHBRNkAcHMre58xG/wHDz5b+DaS5DvzjhTtOtouksisk9bBpBHQV4Avj0X9s+dNOz88YzG0uoMd3H4GNJOcGmWrqBEBC7s484yWZmc9v5O8SVBCIwO2pkMe78zWpjZ8L71iE5uyFh8DtGiB4yfMk6Ar39w+B56Hy7ckZbfnc7snl78aesBiK5kfD6uHDY8spgWXNZD+029GDgU9fZ/jbJkDa1zI3JNTMUR7LdcOHZlo/6NOQa1ML8se+vC7uDIUXUbpOdLNg80TxOjxtArlLREmNRhGnt2ZIXilPapBoAovZeP3AeYSGNHAGZMpIabVE47mjd8sV/h307bFvAZ+vRfjOMWd8YP9sIN/V4DdrPDR2vz/eZPxGGoNI/QLptKmN257ED7/SAMrAVXOHrlZC2zBrnTVzlPISmjAHIl7aXoCFgg5+xm+ZxcRFVitpia5edijsLEmgBNb2tjQ8vx8IZlCX8de6O+cQXugUCOQIUea7UJcz/NdkVu76YZnAYTAzBpVD7q99wZEHbuaM6ekxbeaKEa0mHc8RJga9jPLyQeiwMHT/1YqiRaNmwbzYs1st2Mhz/1kPmozbBGxc4bJPS
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?90dqzqVNshYaEaiS6+jh4VWSRk+sGWRBxxJ3rSL2ZUW/4RkfcZ6ImefhQV?=
 =?iso-8859-1?Q?tQS3Q/gaBMwnCB4U3AhqSJjpS7WxjHN1Px2bjddgV+3Yb4Gp/SLM8naVnn?=
 =?iso-8859-1?Q?waOrsZdcEsQjDQCQY3tCp2gSWJaTySH2q8O/kpWjc95NWiUcPaWllNk/ox?=
 =?iso-8859-1?Q?VMo8Mppc552jp26sjaIv447aldbrsWNXwxdO7l3MaB5WoH0gksZviJjN95?=
 =?iso-8859-1?Q?Y1Ymu9nv3/l5oOqPQEiKihv8HuXDxpY5aCFvY7v7pocU/sWQ+54zFqHd2V?=
 =?iso-8859-1?Q?TkfjT5ILJRcFtGgx+0HZ1AfMtTtHY3Cmn6iJMn+VlafTnDciDYkQJvJVM2?=
 =?iso-8859-1?Q?AHjS0/wVO0qBnoDqw1uEqRIPNvW0FvpQ/s113+8FtiFEmHeWT5PhITgHrG?=
 =?iso-8859-1?Q?AS+N0IxSs27I3PBAoEtjECSNxj5j7zxcaCFl1LSibFu52huj5HAOj6vK71?=
 =?iso-8859-1?Q?3iAikoIOp6JnfhhTP8iO9ftRg+BRp4+79RWYTInRdhwUmczVNS1qFy1GjR?=
 =?iso-8859-1?Q?lwE5QObeIb9FsB6RYWpqeCrBJB3yyrRkBlcuSdCu6DtyEkofbrxytWSuKp?=
 =?iso-8859-1?Q?1qFalR8HXESOxcCqQkuHE01IHoXpAQAuIsT6+YcrbaObNKkjvQ670PNWIr?=
 =?iso-8859-1?Q?QdVbF9jcDdxRreM9NVGouPZkyTCX8/EeO9udY684pIY3/l6t7jcuzsbey4?=
 =?iso-8859-1?Q?6gTvO+QqLsOIh0meJ5Ip8hYHfhGD8RVIrh3W0kGpuaiKDVG4YjVizwLp9c?=
 =?iso-8859-1?Q?Oxjzv+YOa228/Pa9uQb9EQ1lGWCLn5TOXH0YqdWbtEPCTd0Xbf+SdZGaCJ?=
 =?iso-8859-1?Q?L/e0x1NrDD6/sFv/lVfAJipwuLC7LhSuawwAbnmNYQbQC3kpzGGYEDKMIK?=
 =?iso-8859-1?Q?bj7d8xpKh6hCwZZBEQ1lETmh9T99oV2hxR3C6ql7Dry0SXj8UNK+2RSead?=
 =?iso-8859-1?Q?6XjnJsIbIBVukaunCQPhYncWwMQ/H9yINSTrOhIvsfL+ftrPwhU877Ykeu?=
 =?iso-8859-1?Q?aAWerjHLFPIBOLh1UVB/nv5ta4MGpT/JGK/Tm1CsURGOTF0JknqCbU0VL3?=
 =?iso-8859-1?Q?+U2+p5VztGT/6fuHbX8Ce4nqlQrQ6ASSB2xqZnD3yGkRJxGBlJCXwXbhGz?=
 =?iso-8859-1?Q?F235fsNXhlOa5Iwki0jye+I74djWUj+LJRsWD2uYnwr8yossFLVngHiQEH?=
 =?iso-8859-1?Q?KMGnrUM/CfpzZ9zB6j5MfK3Pjj0Qv0KZwmjxIorgF3Su9Zskpj1G19wXqA?=
 =?iso-8859-1?Q?og57A6dt5NGop4mcbA/z/K/J/NzCNNMt84x8+t7dnI+Q81dcSbdufocAr/?=
 =?iso-8859-1?Q?t9vuNxzXYVWrpCwjcf8r8wAWOdS9oYvxxK5XRkHSjRUO6bq54TYvuR8FVM?=
 =?iso-8859-1?Q?U73MYRhokwid9qen/P0WIsT5tTg3YF8wk2KruI6SGu1vQ4NbTaEDW+7NEs?=
 =?iso-8859-1?Q?ce/CUcfGIFaBeJqSAMsU8/bc+FJJXCiHFqvmpunywxHvi43PLxec51iXRH?=
 =?iso-8859-1?Q?kpIngGnjJaoS2rf6sZLSoRdZlW1B+YLdM6nroZ0z6ZWhhb+PV008d1cu4T?=
 =?iso-8859-1?Q?5VaByzKbuhZAova7wD0FfBwCSBxrbYd9bnN5/aQMGAimGl61fIkw97IokS?=
 =?iso-8859-1?Q?pTvg3oqG6JeUzprLFYgbv9iF7L5ZBIlxQktWlQMWWU+nDWcp75/6XizlMG?=
 =?iso-8859-1?Q?3Uy9SO6cIOU6/j4XXMsK+o790Z+yQRKj/cvlXRJKf++HnVhQVCKmeExlo8?=
 =?iso-8859-1?Q?YLCx7zEbMVJWtZYo4SsDh91cwK/nt6joTVpuOnYjo65X1xznN6i9nDKRMu?=
 =?iso-8859-1?Q?4SfeIlwzwg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	iZCKJf6YtbCtRSuIlSfWdRgoydgwLwiAVfLK91H9o60ZMnnLZHjEsjWeN4tydiS8qKnD9oaIJKPbBgnRSHpumaoPMInbeRAxEtxsWIoOb8NHkrJvW80Laz3xQV/eapopfFwZxqyTqKcOznQYEKSUacyAloVin88OtqC1csjSHn7U10cVrdX9xBWZ5OcbDZ1nMoUmM9vGHTWnUWzz4GPrjzH3jnxKEhqpTF1LM2JEYfiGS0V+4GUf6zHeOIsU42YaWomec5K6bqwt6feTeGvAoVm8cZ+J58/QZw4tzOMYGKBJZJmtPly2RBo/yijrmfMI1Za1Nkb9ccUCM+aclAy63w==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bc95bd6-2bde-4ecb-e29f-08deab504fee
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 09:17:35.9552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EhC9oh8KYKXQ72uU48z2GpvKSxR2u1EMSs9LpBzKuvNGuBVsMebJEopBRguHrmC4rfgv0AO5UkJeaBK1XxBtHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR03MB8273
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDA5MCBTYWx0ZWRfX3DjPLXhb7kO6
 zh5b2fy8XyS8tXqDjyqplY4aAMJRPW5s/E74wslvuCgXLJhzWsobW05WsIjbR6hm4IX2YmstHnc
 U8ek58Lf36YrHPNT3TklsNYPof8ouwhDg8tu6hAU7kafvIILtUmHPRGfk3s948gtgD2bELnK58d
 j5dbOXPTIFu6F9vuTpBOuX/0DAIKLAJIMdB6ILv0omH8Sn0Mpfd5c5VmE040uvheMsnDQD7XwdK
 9O91agSh2zrqpL77z1J0TLYVSkt6wuL2De4jpfHtILuKXbZaO0hqoxIWI2+Ac20PahGyXhU2B48
 Jj+7UfPhMn3fpEyY4BQTfd1yg/Lg9Ar/Y2LAXWbUeFhq/u73EbmFgSFHelF+PDbXzFoQDFqSRwa
 PulbyzSRzZOMNhh4uZoli5cAo55keqAqm+pHNxMESEr7Xi+QisSOK/CE0nO3Lku5gKAWEACEeWA
 1v3etGbfIynYQ8x1pTQ==
X-Proofpoint-GUID: 9mGDrNv69fOA0F2L9e24wLPNYdo5FLEE
X-Authority-Analysis: v=2.4 cv=DvxmPm/+ c=1 sm=1 tr=0 ts=69fb0732 cx=c_pps
 a=PxTiP5NnQLoflLcDylFrfg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ugNRTJOwpmtT476g4l8T:22 a=uherdBYGAAAA:8 a=c92rfblmAAAA:8 a=VwQbUJbxAAAA:8
 a=gAnH3GRIAAAA:8 a=IpJZQVW2AAAA:8 a=pGLkceISAAAA:8 a=07d9gI8wAAAA:8
 a=ag1SF4gXAAAA:8 a=H3tf1KL8IO896_5gjrMA:9 a=wPNLvfGTeEIA:10
 a=GvGzcOZaWPEFPQC_NcjD:22 a=IawgGOuG5U0WyFbmm1f5:22 a=e2CUPOnPG4QKp8I52DXD:22
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-ORIG-GUID: 9mGDrNv69fOA0F2L9e24wLPNYdo5FLEE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060090
X-Rspamd-Queue-Id: 995714D8844
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[metafoo.de,analog.com,baylibre.com,kernel.org,gmail.com,pengutronix.de,lwn.net,linuxfoundation.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-8793-lists,linux-pwm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[analog.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Radu.Sabau@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,radu.sabau.analog.com,dt];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	REDIRECTOR_URL(0.00)[urldefense.com];
	RCVD_COUNT_SEVEN(0.00)[7]



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Tuesday, May 5, 2026 5:28 PM
> To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
> Cc: Sabau, Radu bogdan <Radu.Sabau@analog.com>; Lars-Peter Clausen
> <lars@metafoo.de>; Hennerich, Michael <Michael.Hennerich@analog.com>;
> David Lechner <dlechner@baylibre.com>; Sa, Nuno <Nuno.Sa@analog.com>;
> Andy Shevchenko <andy@kernel.org>; Rob Herring <robh@kernel.org>;
> Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dooley
> <conor+dt@kernel.org>; Uwe Kleine-K=F6nig <ukleinek@kernel.org>; Liam
> Girdwood <lgirdwood@gmail.com>; Mark Brown <broonie@kernel.org>; Linus
> Walleij <linusw@kernel.org>; Bartosz Golaszewski <brgl@kernel.org>; Phili=
pp
> Zabel <p.zabel@pengutronix.de>; Jonathan Corbet <corbet@lwn.net>; Shuah
> Khan <skhan@linuxfoundation.org>; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> pwm@vger.kernel.org; linux-gpio@vger.kernel.org; linux-doc@vger.kernel.or=
g
> Subject: Re: [PATCH v9 4/6] iio: adc: ad4691: add SPI offload support
>=20
> [External]
>=20
> On Thu, 30 Apr 2026 13:16:46 +0300
> Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
> wrote:
>=20
> > From: Radu Sabau <radu.sabau@analog.com>
> >
> > Add SPI offload support to enable DMA-based, CPU-independent data
> > acquisition using the SPI Engine offload framework.
> >
> > When an SPI offload is available (devm_spi_offload_get() succeeds),
> > the driver registers a DMA engine IIO buffer and uses dedicated buffer
> > setup operations. If no offload is available the existing software
> > triggered buffer path is used unchanged.
> >
> > Both CNV Burst Mode and Manual Mode support offload, but use different
> > trigger mechanisms:
> >
> > CNV Burst Mode: the SPI Engine is triggered by the ADC's DATA_READY
> > signal on the GP pin specified by the trigger-source consumer reference
> > in the device tree (one cell =3D GP pin number 0-3). For this mode the
> > driver acts as both an SPI offload consumer (DMA RX stream, message
> > optimization) and a trigger source provider: it registers the
> > GP/DATA_READY output via devm_spi_offload_trigger_register() so the
> > offload framework can match the '#trigger-source-cells' phandle and
> > automatically fire the SPI Engine DMA transfer at end-of-conversion.
> >
> > Manual Mode: the SPI Engine is triggered by a periodic trigger at
> > the configured sampling frequency. The pre-built SPI message uses
> > the pipelined CNV-on-CS protocol: N+1 16-bit transfers are issued
> > for N active channels (the first result is discarded as garbage from
> > the pipeline flush) and the remaining N results are captured by DMA.
> >
> > All offload transfers use 16-bit frames (bits_per_word=3D16, len=3D2).
> > The channel scan_type (storagebits=3D16, shift=3D0, IIO_BE) is shared
> > between the software triggered-buffer and offload paths; no separate
> > scan_type or channel array is needed for the offload case. The
> > ad4691_manual_channels[] array introduced in the triggered-buffer
> > commit is reused here: it hides the IIO_CHAN_INFO_OVERSAMPLING_RATIO
> > attribute, which is not applicable in Manual Mode.
> >
> > Kconfig gains a dependency on IIO_BUFFER_DMAENGINE.
> >
> > Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> In general have a read through Sashiko reviews once they come in and
> if you agree with them reply to your own patches to say what you are
> changing.
> https://urldefense.com/v3/__https://sashiko.dev/*/patchset/20260430-
> ad4692-multichannel-sar-adc-driver-v9-0-
> 33e439e4fb87*40analog.com__;IyU!!A3Ni8CS0y2Y!-
> G5xU6m5PVXdQJCRVp_OOtLEM0gRiLsoZigLcBOrGi00oHLlyYgtxQAtx7azQuyZ
> Bkv8I3Cgy2WoEg$
> No perfect but another one in here is something I missed completely.
>=20
> A few of them called out here but please make sure you've addressed them
> all or established them to be false (which happens!)
>=20

Will have a look at Sashiko review in order to address everything in the ne=
xt
version.
I will also reply to each patch and mention the change, argue to why I thin=
k the
raised concern could be false and perhaps have a follow-up discussion here.


