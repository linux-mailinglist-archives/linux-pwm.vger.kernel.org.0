Return-Path: <linux-pwm+bounces-8147-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LB9H6fcm2ku8gMAu9opvQ
	(envelope-from <linux-pwm+bounces-8147-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Feb 2026 05:50:47 +0100
X-Original-To: lists+linux-pwm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D817E171D04
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Feb 2026 05:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6C5D30238DE
	for <lists+linux-pwm@lfdr.de>; Mon, 23 Feb 2026 04:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B8923EA85;
	Mon, 23 Feb 2026 04:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="X3G+RLVN"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0833446DE;
	Mon, 23 Feb 2026 04:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771822212; cv=fail; b=vD9/LV8npYDK/kPqjz9D47YPp5QRmE/9A13ZPl+a1Oi66pB7QuUGfCsWIc8zR+M8U6btgHv2C/rHvfCdAdv1As050hcUeWT8fgl3uW4YWgyfKIUE6F0Uec6Fr7lb8SDZRCGxeeTwwv28Fw/ms3NQrHivu2i3W+czeDliD4Mv1d0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771822212; c=relaxed/simple;
	bh=HhUHrT6a+5wehg9+IYyNrj5vsX8j+eF4FFCmd5LR4Rw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CzVhkNXBZFwS9zkFkQB0ULZcAOOXrf1JHWCBRWmlOiDRk28QGFrkXXv5ANhcbngJ33bDOOQnFC2GG2aEZJuxxkF1UX/w7HFU5LcHXbpEYpm0wBqNAjOOaeIbkabK0AKfwOKiY/u5Rqwn00VYiJs2tQvhEZhsWrmdilAWKUNJqyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=X3G+RLVN; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61N4fLxu2933591;
	Sun, 22 Feb 2026 23:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=QW5rJ
	3FcO/NUkjC7BAyE7sSiX/tt8LRQuWVnNuHoH9M=; b=X3G+RLVN1CoiI5ldlgo64
	Tc+BoFkyzccNB+C5imJe7QtCYHTSZXUc791QKZmDLf5CbkPMLt2J+dlAKKsle62M
	tqhacHzVI3KOcff2zduiEc07MO2xy1hJr+tA+0mujg0xVa+NShWQQgu0E4em9uhc
	z0XAoL4Fn8yNtaBKCzAbmc9CWom/j3tMBpxKBGmPsGXOv0miAE295P9SGGpYj5Ar
	jscwti7h7FyJVTN88OMBASu1bm1snmb1+CzzXDOtvst5kCr6iqPpX0HLe+xrbHgc
	ePe200+vmZTTqDnjLtHddLkiolCEbzCKPa+mryJc5IJeSOYYe7jLRqVXIi671M33
	A==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013002.outbound.protection.outlook.com [40.93.201.2])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cf7b94emu-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 22 Feb 2026 23:49:41 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0hFCkJUXlUu9hwF9xok25+tsqomR1dL28AvW4ENNxx85QMvcBABGm6nr9NcSjqRu3ns5PM+3HcpmPY9d39gjJpnge9UspbX41slytButjkBodC7P9/RaEYSDETbSG753XXqia/OhKsD8YVO0Phtv+weqAgiekQagtWw2KDZyCiHkJuO6ZYJy+ZasUAQD6Bogr6hxRhgiWR0ly7gahWauA2QW7kbSDQyV5xzhZZn6sqqWgE33UAvkrnzqo2yRq/TIk4f37hdXqcgiW6ibiZUuVMreD64l3H2I1qTAgtMk7TH32+lTWAec6tKWda9SOUiQ6Mrk17cuTMsBNHm9fZwNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QW5rJ3FcO/NUkjC7BAyE7sSiX/tt8LRQuWVnNuHoH9M=;
 b=qTIeTMv0cLtoZq7jwbspGiNh5fg+AIjsDYkv6Tti81CdGZuTydQufkkfw2Mgs95YRh31IFzMFJSLTL486z8YX3NtiGVPqr1myWSBoIAmQNYc6EXxIWLHW/ihZDX31kYnVtM7nfXxp5PWikt1aJTTXztxLy4xtuIXCtOMjt7trxxXRPzlDLZtynupeVB7Y0brbTDC4V/tGyVFIGRijAyCH/ETz/hi6Eay/M5lAHjEorgDUao3hLsk1v64rnyHaECqqWiZdxBaS8MQERxWRemOZW4Z5/xg+/qdOqoLlr1HIx3sne5OTnuJBPViG4sV8aTLBXaNKeWCHFd7oM4dgEqk4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB6351.namprd03.prod.outlook.com (2603:10b6:510:ab::18)
 by MN2PR03MB5261.namprd03.prod.outlook.com (2603:10b6:208:19e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Mon, 23 Feb
 2026 04:49:38 +0000
Received: from PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::1578:4572:29b5:2442]) by PH0PR03MB6351.namprd03.prod.outlook.com
 ([fe80::1578:4572:29b5:2442%4]) with mapi id 15.20.9611.013; Mon, 23 Feb 2026
 04:49:38 +0000
From: "Torreno, Alexis Czezar" <AlexisCzezar.Torreno@analog.com>
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
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<ukleinek@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>
Subject: RE: [PATCH 2/3] iio: dac: ad5706r: Add support for AD5706R DAC
Thread-Topic: [PATCH 2/3] iio: dac: ad5706r: Add support for AD5706R DAC
Thread-Index: AQHcoj9l13ZGly5RuEGu/Ihr2ZaVRrWPFZIAgACTxTA=
Date: Mon, 23 Feb 2026 04:49:38 +0000
Message-ID:
 <PH0PR03MB63517AE635266411B18E1BD7F177A@PH0PR03MB6351.namprd03.prod.outlook.com>
References: <20260220-dev_ad5706r-v1-0-7253bbd74889@analog.com>
	<20260220-dev_ad5706r-v1-2-7253bbd74889@analog.com>
 <20260222185704.375a2a0b@jic23-huawei>
In-Reply-To: <20260222185704.375a2a0b@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6351:EE_|MN2PR03MB5261:EE_
x-ms-office365-filtering-correlation-id: 85da856c-e148-44d3-d509-08de7296f336
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?2CzBZKENzX7pa0YOiBos/l3pJX7IS4XQTI9d/mAO7SSKgIkbQkcOBv4Oei?=
 =?iso-8859-1?Q?xQe+T7COg6103L0pdephCW3/7jkyWuNqdhXjQJFjElugh8XEiJwZW/Plg2?=
 =?iso-8859-1?Q?CplUque8ojc4Us5j2rq5f+pLiy/kEI+eUCP6scSPde/jsenitQynxfatKu?=
 =?iso-8859-1?Q?ZhhUbDYTYbUNZeQXdDHLAcduOzJJBgxsDBD0NIJWwAobUVXfqmJQ2w3AYn?=
 =?iso-8859-1?Q?p0kBjb/P1Zikqw0ER0W34vkd833FfCiE21CuLt8xgNRLeB7uifB59aii1T?=
 =?iso-8859-1?Q?eB7SkbSGJ01FNBAYM3VsjVwRrxXmCi83MjSEFU+DyjyTf+UE9Csdg4gPDh?=
 =?iso-8859-1?Q?42XADMQUr9coqLwIbnW+Dz9bFtl2iVu0vTA9h2NLm0cD/+McScJlXUUQ/6?=
 =?iso-8859-1?Q?UaW8QJDFzbmbFiBkuDDwd4Xh2pX0ppkSENgwCjdZ8KRwYSXnSJH5AvN3k4?=
 =?iso-8859-1?Q?dQC2ykH8YgWCGdtj2nQwoOrGBYUneKTqqYigZ/lzRgQyN6sPwSu/+zpb7z?=
 =?iso-8859-1?Q?MBLZh4DOmR108SSF/HJeikllOKVJD//U+blDamkBdDyx1MjMNvzuOntquv?=
 =?iso-8859-1?Q?fW44qYnn/PEeVVZV5aPm9ZRbJbvr4bSM4+VYE/QQuiesBihJvEz7c2vQly?=
 =?iso-8859-1?Q?WCHWAGP7AgDifKwOow4PM++RyHOOc9roLo80POm4o6U9EY14ZHe1O4pdTf?=
 =?iso-8859-1?Q?ZNWCA6ch7GJoFlDw8rB3CZqEfuWOrcNbEWlliaBrABD0nU1StCWHwm/nSX?=
 =?iso-8859-1?Q?Z0buQuAbJGUsl3ocA+IfR0F8JZF3izcDGqvuOecC7y7oAwMwn2d35arXgs?=
 =?iso-8859-1?Q?a8D6F62UqWkCCBE5UyAFTHI0OUdq+T3m+mp4XGg5lWIlMlSgPN06Nmg/08?=
 =?iso-8859-1?Q?JNlX1UQuyTmTSECpMcT5z8rjw0GnD1wL15gcyzfV9ckRNCVXjFwdr7dOoc?=
 =?iso-8859-1?Q?LkdVHp4799c/i2+sgdSkpOWEK6wP0ULPyOZC/odPMOqEbUjxJN5qO55NWf?=
 =?iso-8859-1?Q?M15wb5sr5urJpFDyjUeWVq5iHx80+s64o1htUNkikKMVIy6KoWhwR7kzuQ?=
 =?iso-8859-1?Q?4mKgOpwMPsAFfpX8gDfTpPiE79pe7N4jSFvKgXFNiaj9d2XU6kZkUiqLUB?=
 =?iso-8859-1?Q?fmKhWCywWWz5x4DKzTjK46QJ+36KwYgTGbAWd9CrsOWXDJEQPbRmlh0Fti?=
 =?iso-8859-1?Q?P89F9LDNYj9hP79AyJueUFphSjbjIdL41yMSfV3S0MGcJ2jikLFIX3THbH?=
 =?iso-8859-1?Q?CKx868lfJl1+4S7D4u53Kce9SHqM+wXP+mAR2mifBvX8zkDNOs46gE8m4q?=
 =?iso-8859-1?Q?WFdVGB3rALZP6YevbpmyA8ex5bx02bfB5aoQ4etXmQlYWx4mjIqCKkgW1B?=
 =?iso-8859-1?Q?6QmN5zoETElwD0FIUPqR8Omgt4scSWuIPL5gyN7yfidZDWh0O4zE1h8ZSl?=
 =?iso-8859-1?Q?2R+QW+dplLqOlMIr+HSAWx+B3VE0nRNjCl1/JCiq0zy5srie1t8YMZnSH3?=
 =?iso-8859-1?Q?rnWGND/Gwx87tE/tPdYou7I4V6xZuOri/+m9z1z8YS0hdMTCkhd7jAru37?=
 =?iso-8859-1?Q?TJcV4JaGKDUz3NeddBhM6UyD6Cc5hySP8vgudsa5Ih1ChCWZGGN3nVIP7f?=
 =?iso-8859-1?Q?qgN3gneExfjE0bmnMV5Raq4dMJRP2CisDG+IGKFeG6h9j/o8U61GMAY77I?=
 =?iso-8859-1?Q?Fz689JNZlZBTO2TLwvk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6351.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?xGi/u4dteTBhuPkUIVsDsUvV1NBNtppBbxQsR0/nt91Wra1DJfg+pjlhgP?=
 =?iso-8859-1?Q?heuKEYF6iKOVjbKfiS/hNlEC+qNBBJUvREnXk/jZdIAP/ekSNGso2tr7b+?=
 =?iso-8859-1?Q?zrk4j2x29+SmvTEdaN1j92I4XZJUSwMDeflhTMjQyxtS/nM2lha/R8MINZ?=
 =?iso-8859-1?Q?Bx6oUVWnu01AlwtLtJTy2c6aKQlI5UENFyNiwjDHdKeq9SPPXVTP8kgOSc?=
 =?iso-8859-1?Q?3DfXLveAMdmelqtRmih+AGA2fVRQ2OuBaqdPF7EOkRKyf4bKsp108fmCrX?=
 =?iso-8859-1?Q?CxRIWi5dpfKVtxUgmuQ/nQdbscCpkCdBTk61OCkjDNS6XRniJmeNvYmKWt?=
 =?iso-8859-1?Q?yq7+mnle90R2/e9rkKk9zvAgEGhkxE4dR4qQepEy3NgqbW27UapXDE9O/0?=
 =?iso-8859-1?Q?h5h8fC6h2SOSziiHsADctVgXMAflv41U3s0ixGTt4yuGv+otbhYLlwQtaL?=
 =?iso-8859-1?Q?KHeGBjjmZc8hS0jX3bZ2YaRy0HvV0xM0gfKM8MZlGF961AmQpEM6tyP9hT?=
 =?iso-8859-1?Q?mIzypbGNjIUe99YvGBu42eQGWDUBZ8syLspMPxPp0vsXaVw5YlZyHmYP+I?=
 =?iso-8859-1?Q?QjlJjaXRpAiHN96JMU1i9oBhiVtOcgfgLUa9DJMi1WNNXI9HpBkUHf37oC?=
 =?iso-8859-1?Q?Xk3LOvLEjN2//jx7eqJ0+p++gdUQaZCwFZwQyBM3QfGAMhAhajuL80ytbt?=
 =?iso-8859-1?Q?6cbyTlLw3KDw3f4mNrGrKC6jSQGhP8gHBb0YvXMGc48a1iLp7T+6YhhusX?=
 =?iso-8859-1?Q?W4TKbj7k9PEzoj6CROmXFQZk9gD3lt67VkvLILxSAF7oeqfQC4EhhSEJzT?=
 =?iso-8859-1?Q?yuTvQnPCY5tVV+H39/h6aeK+y6ZpAeJRIShHx/zIAcY0Qtn+t91LXtoBoe?=
 =?iso-8859-1?Q?Xe4S/imKaHMBRnMuK23TtMyRKpVYb00fbjVi7aN9m4G3iP0hqKQ0JouLti?=
 =?iso-8859-1?Q?rIgY3C1PaEYolpwJsxqJU5vh0B4PynN+T9Ng8IxBWvZLQZQHZqoyiTf+kw?=
 =?iso-8859-1?Q?e9PW5nsHo9H0Sq88y17wC2RhI32CW3e0iryJL2oNSqzwbRFXGz0bwj5il7?=
 =?iso-8859-1?Q?e8P49QCgJHED24yxwO0Li62vVswj5+b452YVMdbVH4+qpR/9HP7r4IHxXz?=
 =?iso-8859-1?Q?0tG1bffljlXdTf+qsoFwDykewRoYu1mUOMhyMFRWofwSA2PhUD8E4aL0YT?=
 =?iso-8859-1?Q?XX9hIKM2xKhQU+rDyARIWGY0zLtVgix5omsoE6UoVXRbWTbhjaCSS7zTSX?=
 =?iso-8859-1?Q?ZIgvRCrZ+Gr6Xhy7q5VAAr66SwXGMhq7YZFxN+H47c8a3MlaDb2YSjYqFt?=
 =?iso-8859-1?Q?TX6yyL66RC44tBpRurYWQrr/orC5Wr5WtvXecN4TNOVC0udvYMtOjS6V/x?=
 =?iso-8859-1?Q?0eGu5hFldC22Kr6uJn1YC2ICekkL+vycGmK/5DkV5FwQLdyjy4z4CTsRgY?=
 =?iso-8859-1?Q?Yh30LCYHVBGHrKiAXfj5qIVxV1h662Njs9ZiaTR2Zq+BL87ZTs2vTxi9QQ?=
 =?iso-8859-1?Q?9GyByyWhx8f5oW9C8cGqj646oXmYybUnhfiRj+LIx5v0dgydcbyDhG3OAS?=
 =?iso-8859-1?Q?m1mfkF27mHXGg96FL+Dj2Ia+ecgbSOUEKt3mPCcZL0l1RzyrKUI8VF+XxW?=
 =?iso-8859-1?Q?L7V11dyuRsByWtclTj7zg/yz0JK4Or+4feu9LuoC42SEU71SvKN1nRCEIY?=
 =?iso-8859-1?Q?skgL9X9QN8lTzPLvZAxK/e1NRlcWPXQcGbBqTMLqdvy2Fr9r1r5qcqeYE+?=
 =?iso-8859-1?Q?UVxYJ06MsIEyCTN4Rf6cuiJB9Pr7eDHYspqhQTuNelYCF6y8F5EiCMR1Cu?=
 =?iso-8859-1?Q?3A/BGDfS8P+bgp1WQ90Z4FY0SoWebxs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6351.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85da856c-e148-44d3-d509-08de7296f336
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2026 04:49:38.3918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cT/qL0dh97gUg551/hx3KeZ3GSwBEjDrlPq1Kq/vzaIPzNHTCHijsPoLL3MxhhUYAceQyQ0a0o9Dji6of/6qUXSamP6GAWEBxwsHRbVVo28=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB5261
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIzMDAzOSBTYWx0ZWRfX+ENk6LH6PloH
 GMuVSCBIxzNYjntQjCfTNxNrg1LzrrV4lqqiBxeUYjksqeU+22Y1RGsQ4Q5JuIhbITQmvDyfONj
 vc87TcoG7l2AyLVUO1LWf7AJzEJfe5kRWI51VMlMQgRzTfZ4vYhL6h4CqhDokQYTugQX9BmKQpz
 CXoYuFBzPg2PFYwGcgJOio7EvdxYbPk47ReBTUHOg60Ovnmo+MVRaGg0GFrW6BzBokQcmv8saP3
 6M2RcKPDrlWw11Q2mw/tmoE3taiOQxp3IJTgub3oBV5jkP3XlPupC6R4RV+uwWtYSdgwh9Z7iET
 UZboRr2Si81AIgduzxK4BbvXMCw8bNwT+xY0RUgxszABccYqEXNswgeBArFrwPeJL/G42wh5O20
 aVTsupsVfzD54NjbM/Z1ggX/jHk7n8GLpv4qZJirnfGIu0Vzs4gwE2qgA+9/Lf2RqYMitLcGKCD
 S2J/i5C9odZJ6NMP0JQ==
X-Authority-Analysis: v=2.4 cv=JrP8bc4C c=1 sm=1 tr=0 ts=699bdc65 cx=c_pps
 a=IyT5loBvHZYA5YPQi3EYsQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=ugNRTJOwpmtT476g4l8T:22 a=gAnH3GRIAAAA:8 a=eXML5lbkzWoi_pLQhN4A:9
 a=wPNLvfGTeEIA:10
X-Proofpoint-ORIG-GUID: wIsoYk8ObJetzqqoDYTxvJ5P97rxdXfL
X-Proofpoint-GUID: wIsoYk8ObJetzqqoDYTxvJ5P97rxdXfL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_01,2026-02-20_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 impostorscore=0 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602230039
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8147-lists,linux-pwm=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[PH0PR03MB6351.namprd03.prod.outlook.com:mid,analog.com:email,analog.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[analog.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[AlexisCzezar.Torreno@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D817E171D04
X-Rspamd-Action: no action

> > Add support for the Analog Devices AD5706R, a 4-channel 16-bit current
> > output digital-to-analog converter with SPI interface.
> >
> > Features:
> >   - 4 independent DAC channels
> >   - Hardware and software LDAC trigger
> >   - Configurable output range
> >   - PWM-based LDAC control
> >   - Dither and toggle modes
> >   - Dynamically configurable SPI speed
> >
> > Signed-off-by: Alexis Czezar Torreno <alexisczezar.torreno@analog.com>
>=20
> Hi Alexis
>=20
> Welcome to IIO.  A few quick comments inline, but as others have observed
> the patch is too large and needs breaking up.  Also there is a lot of cus=
tom ABI.
> Given we are reluctant to merge that at all, it definitely needs document=
ation
> and careful consideration of whether it can be done with existing ABI or =
is
> more appropriate in DT.
>=20
> Thanks,
>=20
> Jonathan

Using this reply to acknowledge all the emails/feedback.

Hi All,

Thanks for the time you spent on this large patch.

It seems I will have to split this up first. I think it would be the basic =
driver,
the ABI + docu, then the debugfs. Merge 1 before I submit the others.
Will apply each feedback as I go.

Some naming schemes need to be updated, to properly reflect the datasheet
terms rather than the one internally agreed upon.

The most unusual that a lot pointed out is related to the clock/.speed_hz/
spi_engine. I was asked to make it work a bit beyond 50MHz, using a cora
fpga. The cora processor spi is limited to 50MHz due to HW, hence the need
to use an spi-engine. However, this is limited to the resolution on how sma=
ll
the frequencies can be changed, the spi engine only does integer division, =
thus
leading me to change the clock driver of the spi_engine itself.
I'll try to see if the implementation can be changed to something simpler a=
nd
will make it easier for us.

Thanks!
Alexis

>=20
> > diff --git a/drivers/iio/dac/ad5706r.c b/drivers/iio/dac/ad5706r.c new
> > file mode 100644 index
> >
> 0000000000000000000000000000000000000000..2d718cf7300bcd1f599
> fe715aacb
> > 3170f72541af
> > --- /dev/null
> > +++ b/drivers/iio/dac/ad5706r.c
> > @@ -0,0 +1,2290 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * AD5706R 16-bit Current Output Digital to Analog Converter
> > + *
> > + * Copyright 2026 Analog Devices Inc.
> > + *
> > + * This driver is designed for use with the AXI SPI Engine and AXI
> > +CLKGEN
> > + * on Xilinx Zynq platforms. The 'clocks' device tree property
> > +references
> > + * the AXI CLKGEN output clock, which is used to dynamically control
> > +the
> > + * SPI clock rate for read and write operations independently.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/debugfs.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/iio/iio.h>
> > +#include <linux/iio/sysfs.h>
> > +#include <linux/module.h>
> Follow approximate include what you use principles for kernel drivers.
> That means mostly including everything that is used directly with excepti=
on of
> a few headers that we know will always be included by others (usually bec=
ause
> they are documented as doing so).
>=20
> e.g. mutex.h should always be in a driver that uses a mutex.
> If you are using guards, then cleanup.h needs to be there etc.
>=20
> > +#include <linux/pwm.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/unaligned.h>
> > +#include <linux/units.h>
> > +
> > +/* SPI Defines */
> > +#define AD5706R_RD_MASK		BIT(15)
> > +#define AD5706R_ADDR_PIN_MASK	GENMASK(14, 12)
> > +#define AD5706R_ADDR_MASK	GENMASK(11, 0)
> > +#define AD5706R_VAL_MASK	GENMASK(7, 0)
> > +
> > +/* Registers and Masks */
> > +#define AD5706R_MASK_RESET			(BIT(7) | BIT(0))
> > +#define AD5706R_MASK_DEV_ADDR(x)		((x) & GENMASK(2,
> 0))
>=20
> Define the mask only then use FIELD_GET() / FIELD_PREP() in the code.
> That tends to end up more readable than a macro doing the same thing
> without the compile time checks those bring on values fitting etc.
>=20
> > +
> > +#define NUM_CHANNELS			4
> > +#define SPI_MAX_SPEED_HZ		(100 * HZ_PER_MHZ)	/* 100 MHz
> */
> > +#define SPI_MIN_SPEED_HZ		(3 * HZ_PER_MHZ)	/* 3 MHz */
>=20
> Very generic names.  These are going to clash with something in another
> header at somepoint.  Either push the values into a helper, inline or pre=
fix the
> defines to avoid that naming clash.
>=20
>=20
> > +/*
> > + * Order of attributes in code:
>=20
> I'm not sure how this comment helps us.
>=20
> > + *
> > + * Device Attributes:
> > + *   - dev_addr
> > + *   - addr_ascension
> > + *   - single_instr
> > + *   - hw_ldac_tg_state
> > + *   - sampling_frequency
> > + *   - hw_ldac_tg_pwm
> > + *   - mux_out_sel
> > + *   - multi_dac_input_a
> > + *   - multi_dac_sw_ldac_trigger
> > + *   - reference_volts
> > + *   - ref_select
> > + *   - hw_shutdown_state
> > + *
> > + * Channel Attributes:
> > + *   - raw
> > + *   - scale
> > + *   - offset
> > + *   - input_register_a
> > + *   - input_register_b
> > + *   - hw_active_edge
> > + *   - range_sel
> > + *   - output_state
> > + *   - ldac_trigger_chn
> > + *   - toggle_trigger_chn
> > + *   - dither_trigger_chn
> > + *   - multi_dac_sel_ch
> > + */
>=20
> > +
> > +/* ENUM Lists */
> Don't give generic comments like this on how you've laid the code out. Th=
ey
> just tend to end up wrong after new features are added and don't bring mu=
ch
> value in the first place.
> > +enum addr_ascension_iio_dev_attr {
>=20
>=20
> > +static struct iio_chan_spec_ext_info ad5706r_ext_info[] =3D {
> > +	/* device_attribute */
> > +	AD5706R_CHAN_EXT_INFO("dev_addr", 0, IIO_SHARED_BY_ALL,
> > +			      ad5706r_dev_addr_read,
> ad5706r_dev_addr_write),
> > +
> > +	IIO_ENUM("addr_ascension", IIO_SHARED_BY_ALL,
> &ad5706r_addr_ascension_enum),
> > +	IIO_ENUM_AVAILABLE("addr_ascension", IIO_SHARED_BY_ALL,
> > +&ad5706r_addr_ascension_enum),
> > +
> > +	IIO_ENUM("single_instr", IIO_SHARED_BY_ALL,
> &ad5706r_single_instr_enum),
> > +	IIO_ENUM_AVAILABLE("single_instr", IIO_SHARED_BY_ALL,
> > +&ad5706r_single_instr_enum),
> > +
> > +	IIO_ENUM("hw_ldac_tg_state", IIO_SHARED_BY_ALL,
> &ad5706r_hw_ldac_tg_state_enum),
> > +	IIO_ENUM_AVAILABLE("hw_ldac_tg_state", IIO_SHARED_BY_ALL,
> > +&ad5706r_hw_ldac_tg_state_enum),
> > +
> > +	/* Sampling Frequency part of read/write RAW */
> > +
> > +	IIO_ENUM("hw_ldac_tg_pwm", IIO_SHARED_BY_ALL,
> &ad5706r_hw_ldac_tg_pwm_enum),
> > +	IIO_ENUM_AVAILABLE("hw_ldac_tg_pwm", IIO_SHARED_BY_ALL,
> > +&ad5706r_hw_ldac_tg_pwm_enum),
> > +
> > +	IIO_ENUM("mux_out_sel", IIO_SHARED_BY_ALL,
> &ad5706r_mux_out_sel_enum),
> > +	IIO_ENUM_AVAILABLE("mux_out_sel", IIO_SHARED_BY_ALL,
> > +&ad5706r_mux_out_sel_enum),
> > +
> > +	AD5706R_CHAN_EXT_INFO("multi_dac_input_a", 0,
> IIO_SHARED_BY_ALL,
> > +			      ad5706r_multi_dac_input_a_read,
> > +ad5706r_multi_dac_input_a_write),
> > +
> > +	IIO_ENUM("multi_dac_sw_ldac_trigger", IIO_SHARED_BY_ALL,
> > +		 &ad5706r_multi_dac_sw_ldac_trigger_enum),
> > +	IIO_ENUM_AVAILABLE("multi_dac_sw_ldac_trigger",
> IIO_SHARED_BY_ALL,
> > +			   &ad5706r_multi_dac_sw_ldac_trigger_enum),
> > +
> > +	AD5706R_CHAN_EXT_INFO("reference_volts", 0,
> IIO_SHARED_BY_ALL,
> > +			      ad5706r_reference_volts_read,
> > +ad5706r_reference_volts_write),
> > +
> > +	IIO_ENUM("ref_select", IIO_SHARED_BY_ALL,
> &ad5706r_ref_select_enum),
> > +	IIO_ENUM_AVAILABLE("ref_select", IIO_SHARED_BY_ALL,
> > +&ad5706r_ref_select_enum),
> > +
> > +	IIO_ENUM("hw_shutdown_state", IIO_SHARED_BY_ALL,
> &ad5706r_hw_shutdown_state_enum),
> > +	IIO_ENUM_AVAILABLE("hw_shutdown_state", IIO_SHARED_BY_ALL,
> > +&ad5706r_hw_shutdown_state_enum),
> > +
> > +	/* Channel Attributes */
> > +	AD5706R_CHAN_EXT_INFO("input_register_a", 0, IIO_SEPARATE,
> > +			      ad5706r_input_register_a_read,
> > +ad5706r_input_register_a_write),
> > +
> > +	AD5706R_CHAN_EXT_INFO("input_register_b", 0, IIO_SEPARATE,
> > +			      ad5706r_input_register_b_read,
> > +ad5706r_input_register_b_write),
> > +
> > +	IIO_ENUM("hw_active_edge", IIO_SEPARATE,
> &ad5706r_hw_active_edge_enum),
> > +	IIO_ENUM_AVAILABLE("hw_active_edge", IIO_SEPARATE,
> > +&ad5706r_hw_active_edge_enum),
> > +
> > +	IIO_ENUM("range_sel", IIO_SEPARATE, &ad5706r_range_sel_enum),
> > +	IIO_ENUM_AVAILABLE("range_sel", IIO_SEPARATE,
> > +&ad5706r_range_sel_enum),
> > +
> > +	IIO_ENUM("output_state", IIO_SEPARATE,
> &ad5706r_output_state_enum),
> > +	IIO_ENUM_AVAILABLE("output_state", IIO_SEPARATE,
> > +&ad5706r_output_state_enum),
> > +
> > +	IIO_ENUM("ldac_trigger_chn", IIO_SEPARATE,
> &ad5706r_ldac_trigger_chn_enum),
> > +	IIO_ENUM_AVAILABLE("ldac_trigger_chn", IIO_SEPARATE,
> > +&ad5706r_ldac_trigger_chn_enum),
> > +
> > +	IIO_ENUM("toggle_trigger_chn", IIO_SEPARATE,
> &ad5706r_toggle_trigger_chn_enum),
> > +	IIO_ENUM_AVAILABLE("toggle_trigger_chn", IIO_SEPARATE,
> > +&ad5706r_toggle_trigger_chn_enum),
> > +
> > +	IIO_ENUM("dither_trigger_chn", IIO_SEPARATE,
> &ad5706r_dither_trigger_chn_enum),
> > +	IIO_ENUM_AVAILABLE("dither_trigger_chn", IIO_SEPARATE,
> > +&ad5706r_dither_trigger_chn_enum),
> > +
> > +	IIO_ENUM("multi_dac_sel_ch", IIO_SEPARATE,
> &ad5706r_multi_dac_sel_ch_enum),
> > +	IIO_ENUM_AVAILABLE("multi_dac_sel_ch", IIO_SEPARATE,
> > +&ad5706r_multi_dac_sel_ch_enum),
> > +
>=20
> Others have pointed out that custom ABI has various basic problems.
>=20
> 1) Generic userspace has no way to know how to use it. As such, it gets l=
ittle
> used and must not be required for basic functionality.  So don't bring it=
 in as
> part of the initial patch, but instead do it as a follow up patch (can be=
 in same
> series if the series remains reasonably sized)
> 2) It needs full documentation for us to review it.  In
> Documentation/ABI/testing/sysfs-bus-iio-driver-name
>=20
> > +	{},
> > +};
> > +
> > +/* Channel */
> I'm not sure what that comment means. I'd drop it.
> > +static int ad5706r_read_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan,
> > +			    int *val,
> > +			    int *val2,
> Put multiple parameters on one line as long as we stay under 80 chars (or=
 a bit
> over if it helps readability is fine as well)
>=20
> > +			    long mask)
> > +{
> > +	struct ad5706r_state *st =3D iio_priv(indio_dev);
> > +	u16 reg_val;
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_RAW:
> > +		scoped_guard(mutex, &st->lock) {
>=20
> As below. Add scope with { } and use guard() That will reduce the very lo=
ng
> lines here.
>=20
> > +			ret =3D ad5706r_spi_read(st,
> AD5706R_REG_DAC_DATA_READBACK_CH(chan->channel),
> > +					       &reg_val);
> > +
> > +			if (ret)
> > +				return ret;
> > +
> > +			*val =3D reg_val;
> > +		}
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		switch (st->range_sel[chan->channel]) {
> > +		case RANGE_SEL_50:
> > +			*val =3D 50 * HZ_PER_MHZ /
> AD5706R_DAC_MAX_CODE;
> > +			break;
> > +		case RANGE_SEL_150:
> > +			*val =3D 150 * HZ_PER_MHZ /
> AD5706R_DAC_MAX_CODE;
> > +			break;
> > +		case RANGE_SEL_200:
> > +			*val =3D 200 * HZ_PER_MHZ /
> AD5706R_DAC_MAX_CODE;
> > +			break;
> > +		case RANGE_SEL_300:
> > +		default:
>=20
> A default often doesn't make much sense. How did you get a different valu=
e
> from the ones being explicitly set.
>=20
> > +			*val =3D 300 * HZ_PER_MHZ /
> AD5706R_DAC_MAX_CODE;
> > +			break;
> > +		}
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_OFFSET:
> > +		*val =3D 0;
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		*val =3D st->sampling_frequency;
> > +		return IIO_VAL_INT;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
> > +
> > +static int ad5706r_write_raw(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan,
> > +			     int val,
> > +			     int val2,
> > +			     long mask)
> > +{
> > +	struct ad5706r_state *st =3D iio_priv(indio_dev);
> > +	struct pwm_state ldacb_pwm_state;
> > +	int ret;
> > +
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		/* Sets minimum and maximum frequency */
> > +		val =3D clamp(val, SAMPLING_FREQUENCY_MIN_HZ,
> > +SAMPLING_FREQUENCY_MAX_HZ);
> > +
> > +		scoped_guard(mutex, &st->lock) {
> I would add scope the whole case statement
> 	case IIO_CHAN_INFO_SAMP_FREQ: {
>=20
> and then use guard(mutex)(&st->lock) here instead of scoped_guard()
>=20
> That will reduce the indent of the rest and generally give slightly more =
readable
> code.
>=20
> > +			pwm_get_state(st->ldacb_pwm, &ldacb_pwm_state);
> > +			ldacb_pwm_state.duty_cycle =3D
> DIV_ROUND_CLOSEST_ULL(NANO, 2 * val);
> > +			ldacb_pwm_state.period =3D
> DIV_ROUND_CLOSEST_ULL(NANO, val);
> > +			ldacb_pwm_state.enabled =3D true;
> > +
> > +			ret =3D pwm_apply_might_sleep(st->ldacb_pwm,
> &ldacb_pwm_state);
> > +			if (ret)
> > +				return ret;
> > +
> > +			st->sampling_frequency =3D val;
> > +		}
> > +		return 0;
> > +	}
> > +
> > +	return -EINVAL;
> > +}
>=20
> > +static int _ad5706r_setup(struct ad5706r_state *st) {
> > +	struct pwm_state ldacb_pwm_state;
> > +	struct device *dev =3D &st->spi->dev;
> > +	int ret;
> > +	int i;
> > +
> > +	guard(mutex)(&st->lock);
>=20
> Why is the lock needed?  This is all (I think) early probe stuff.
> At that point we are serialized anyway.
>=20
> > +
> > +	st->debug_streaming_len =3D 0;
> > +	st->debug_streaming_data =3D 0;
> > +	st->debug_streaming_addr =3D 0;
>=20
> Where they are the 'natural' defaults (which it seems these probably are)=
 we
> can just rely on the whole structure having been kzalloc'd and not set th=
em to
> 0 one by one.
>=20
> > +	st->debug_spi_speed_hz_write =3D 10000000;
> > +	st->debug_spi_speed_hz_read =3D 10000000;
> > +
> > +	st->dev_addr =3D 0x00;
> > +	st->addr_ascension =3D ADDR_ASCENSION_DECREMENT;
> > +	st->single_instr =3D SINGLE_INSTR_STREAMING;
> > +	st->shift_val =3D 0;
> > +	st->addr_desc =3D 1;
> > +	st->hw_ldac_tg_state =3D HW_LDAC_TG_STATE_LOW;
> > +	st->sampling_frequency =3D 1000000;
> > +	st->hw_ldac_tg_pwm =3D HW_LDAC_TG_PWM_DISABLED;
> > +	st->mux_out_sel =3D MUX_OUT_SEL_DISABLED;
> > +	st->multi_dac_input_a =3D 0;
> > +	st->reference_volts =3D 2500;
> > +	st->ref_select =3D REF_SELECT_EXTERNAL;
> > +	st->hw_shutdown_state =3D HW_SHUTDOWN_STATE_LOW;
> > +
> > +	for (i =3D 0; i < 4; i++) {
>=20
> 4 is a magic number.  Use one of the size macros or define one for the nu=
mber
> of channels and use it consistently throughout the code.
>=20
> > +		st->hw_active_edge[i] =3D HW_ACTIVE_EDGE_RISING_EDGE;
> > +		st->range_sel[i] =3D RANGE_SEL_50;
> > +		st->output_state[i] =3D OUTPUT_STATE_NORMAL_SW;
> > +		st->ldac_trigger_chn[i] =3D LDAC_TRIGGER_CHN_HW_TRIGGER;
> > +		st->toggle_trigger_chn[i] =3D
> TOGGLE_TRIGGER_CHN_HW_TRIGGER;
> > +		st->dither_trigger_chn[i] =3D
> DITHER_TRIGGER_CHN_HW_TRIGGER;
> > +		st->multi_dac_sel_ch[i] =3D MULTI_DAC_SEL_CH_EXCLUDE;
> > +	}
> > +
> > +	/* get spi_clk axi_clkgen, no enable as spi_engine driver enables it
> > +*/
>=20
> don't enable it as the spi_enging driver enables it
>=20
> This seems odd division of labour though.
>=20
> > +	st->reference_clk =3D devm_clk_get(dev, "spi_clk");
> > +	if (IS_ERR(st->reference_clk))
> > +		return dev_err_probe(dev, PTR_ERR(st->reference_clk),
> > +				     "Failed to get AXI CLKGEN clock\n");
> > +
> > +	st->ldacb_pwm =3D devm_pwm_get(dev, "ad5706r_ldacb");
> > +	if (IS_ERR(st->ldacb_pwm))
> > +		return dev_err_probe(dev, PTR_ERR(st->ldacb_pwm),
> > +				     "Failed to get LDACB PWM\n");
> > +	pwm_get_state(st->ldacb_pwm, &ldacb_pwm_state);
> > +	ldacb_pwm_state.duty_cycle =3D 0;
> > +	ldacb_pwm_state.period =3D DIV_ROUND_CLOSEST_ULL(NANO, st-
> >sampling_frequency);
> > +	ldacb_pwm_state.enabled =3D true;
> > +	ret =3D pwm_apply_might_sleep(st->ldacb_pwm, &ldacb_pwm_state);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to apply PWM
> state\n");
> > +
> > +	st->resetb_gpio =3D devm_gpiod_get_optional(dev, "dac-resetb",
> GPIOD_OUT_LOW);
> > +	if (IS_ERR(st->resetb_gpio)) {
>=20
> It's a bit of a corner case on whether the following justifies the bracke=
ts or not.
> I'd not have them but others do prefer the other way around when there is=
 a
> line break in the single call like this.
>=20
> > +		return dev_err_probe(dev, PTR_ERR(st->resetb_gpio),
> > +				     "Failed to get RESET_B GPIO\n");
> > +	}
> > +
> > +	st->shdn_gpio =3D devm_gpiod_get_optional(dev, "dac-shdn",
> GPIOD_OUT_HIGH);
> > +	if (IS_ERR(st->shdn_gpio)) {
> > +		return dev_err_probe(dev, PTR_ERR(st->shdn_gpio),
> > +				     "Failed to get SHDN GPIO\n");
> > +	}
> > +
> > +	/*
> > +	 * Get SPI max speed from device tree. Allows up to 100MHz.
> > +	 * If value is taken from spi->max_speed_hz, it is capped at 25MHz.
> > +	 */
> > +	ret =3D device_property_read_u32(dev, "spi-max-frequency", &st-
> >spi_max_speed_hz);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to set SPI Max
> Speed\n");
> > +
> > +	st->spi_max_speed_hz =3D clamp(st->spi_max_speed_hz,
> SPI_MIN_SPEED_HZ,
> > +SPI_MAX_SPEED_HZ);
> > +
> > +	return 0;
> > +}
> > +
> > +static int ad5706r_probe(struct spi_device *spi) {
> > +	struct iio_dev *indio_dev;
> > +	struct ad5706r_state *st;
> > +	int ret;
> > +
> > +	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> Probably worth a local
> 	struct device *dev =3D &spi->dev; just to shorten the few places it is
> repeated in here.
>=20
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	st =3D iio_priv(indio_dev);
> > +	mutex_init(&st->lock);
> someone else pointed out
> 	ret =3D devm_mutex_init() I think.
>=20
> > +	st->spi =3D spi;
> > +
> > +	ret =3D _ad5706r_setup(st);
> > +	if (ret)
> > +		return ret;
> > +
> > +	indio_dev->name =3D "ad5706r";
> > +	indio_dev->info =3D &ad5706r_info;
> > +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +	indio_dev->channels =3D ad5706r_channels;
> > +	indio_dev->num_channels =3D ARRAY_SIZE(ad5706r_channels);
> > +
> > +	ret =3D devm_iio_device_register(&spi->dev, indio_dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ad5706r_debugs_init(indio_dev);
> I'd bring all the debugfs stuff in via a later patch. It probably adds co=
mplexity
> that will take more review time than people will expend all in one go.
>=20
> Thanks,
>=20
> Jonathan
>=20
> > +
> > +	return 0;
> > +}

