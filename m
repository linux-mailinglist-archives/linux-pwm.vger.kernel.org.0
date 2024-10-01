Return-Path: <linux-pwm+bounces-3414-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F3198BE8E
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Oct 2024 15:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68041C23BFC
	for <lists+linux-pwm@lfdr.de>; Tue,  1 Oct 2024 13:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF2D1C9EBF;
	Tue,  1 Oct 2024 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="F8GUB01k"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8AA1C9DDD;
	Tue,  1 Oct 2024 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727790717; cv=fail; b=DQVfWd37svLdGUqKG4t/gpuB2VZVk3rv0/vLSLZpqIfWtNKN3mEy0Yp+0omi5orper+kFBi/yJ3flMkYyc5Acj9tdGYl0llIiJtGLNckL1WEUUIXM2mI4S4aBgdO+Xp+HDGRbrQuZr09kpbSNGEHLEVYTpHFg7td83wmSELjGQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727790717; c=relaxed/simple;
	bh=Df7S7vDYYpJ+Aij57ckkP4M18OduDWtiqkhO/8pYJ3Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oqkLc6Nf3SMPBLU7ue3wc2JaBam2gkgmTaFeDIYKwq45+jkzWPZUtnV0Zu+bY9i4pD8NkcwBmngLwEFYAOV4mI4nf5npZXE2i06WantSXOILiD4l6Ar5wEKUB776hyFQ+m8T0USsri/akilu3y64WOrla56423VsT9nQDy3Ig6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=F8GUB01k; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491Bmdl8017079;
	Tue, 1 Oct 2024 09:51:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Df7S7
	vDYYpJ+Aij57ckkP4M18OduDWtiqkhO/8pYJ3Y=; b=F8GUB01ksnx+mUawCejgs
	VmpXCmR9BQ/X0dDJRC3qjTWvEGsnBxoPggBIX7CbHASk9IamZXsPcyEXbrs++Vy3
	J/YThq+LvWKD/kUvg605lsf8zVVsyD4qAc+B1jJ9hNXu6Z1nF1sFJC/0TMieE2w9
	zOTnKWQvOkJli5UkK4iH6ALkqjxQL9D9HG4qW3R1SQMcu9Jk8FYXoWQ25SLRTT0I
	eBUwTEx6jxkvZu76i2hE1j5q9dHRXvjfLo54BAPKTokEoUJFcU0PP2q4RrFKbnJl
	F5GNHw6xRWxCPJj6mxfauv6L7HjvTj9Epd8p59IxHr1cLzhrD/tdWle3s8y6PEGx
	g==
Received: from cy4pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17010007.outbound.protection.outlook.com [40.93.6.7])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 420c0dskcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 09:51:28 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dtn0whADYGx4FK+7i7R+aMtkH3f+aIU69WwTg5k9MUOpseFOtvoo+xSfVtPhhON6YWkYoUWfROVXECWbd9VUmnk7iIizswTlL9NptFx00d9b4SYwLTzINbeBJGT/RcZcG9ENoi6HqRql56q7l9x9cQ4t+RvMrAVmkKAJoNYV78L12FvT3rLBegpS6dbJ0laqvLJU4lxvCoxHauwfOvUaaVcNUeeu/TUoaQwHfXhuDNF8VpioE4sHGSOTQrvOxbJTiyfbT2Weea/mhFSGFyL5yPGrM8exLXKluxsRcwe3YoBGUctIkoBQfah8CycBOSdnNTSYvHbB4+sAttR+9NsaUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Df7S7vDYYpJ+Aij57ckkP4M18OduDWtiqkhO/8pYJ3Y=;
 b=hQOX+kUZYPDt9vpnhC7HNWRzhEJxB+CTBAJEmrxOdwHaUE4X5IRNNWeB7Aqa1afIxjihD2/fm+mZwdk7rDKV3lANgiBrJG/dKSeF5R8xBS3h2WKzJtk8bOk2caIEFpwGWZsiNMtdalHZcggvqVMAtVrgLlzN5aZOdnOdzR91QAsolUZ1fBv1RTniE4pv75JvWusPE54jUrkGmfS+hyTCpVUeb9ecZaHA3vkX+t08KR3YCFSRjkzZ/1jk92w1KRvFvnDv46J7phe3XFcxTLyizBKo+qI2TCuSCas9Y5pnPP8Wk5esn6nGfpz/6Apa9jXfSfF+z5OIc2J8GPcNCaatAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by PH7PR03MB7461.namprd03.prod.outlook.com (2603:10b6:510:2ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Tue, 1 Oct
 2024 13:51:26 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17%4]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 13:51:25 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Andy Shevchenko <andy@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?=
	<ukleinek@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        "Schmitt,
 Marcelo" <Marcelo.Schmitt@analog.com>,
        =?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <joao.goncalves@toradex.com>,
        Mike
 Looijmans <mike.looijmans@topic.nl>,
        Dumitru Ceclan
	<mitrutzceclan@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        Alisa-Dariana Roman
	<alisadariana@gmail.com>,
        "Cuciurean, Sergiu" <Sergiu.Cuciurean@analog.com>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>
Subject: RE: [PATCH 6/7] iio: adc: ad485x: add ad485x driver
Thread-Topic: [PATCH 6/7] iio: adc: ad485x: add ad485x driver
Thread-Index: AQHbDaHI9TSlXyKXhk60pta64z5+prJtga0AgARN+RCAABcUgIAAD0aQ
Date: Tue, 1 Oct 2024 13:51:25 +0000
Message-ID:
 <CY4PR03MB3399D90F2A3C7AE3505B60A29B772@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20240923101206.3753-1-antoniu.miclaus@analog.com>
 <20240923101206.3753-7-antoniu.miclaus@analog.com>
 <20240928184722.314b329b@jic23-huawei>
 <CY4PR03MB33991208029C4877760B528D9B772@CY4PR03MB3399.namprd03.prod.outlook.com>
 <Zvvw7ah4wGsl2vjw@smile.fi.intel.com>
In-Reply-To: <Zvvw7ah4wGsl2vjw@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdX?=
 =?iso-8859-1?Q?NcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-1?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy0zYzcwYjg3OC03ZmZjLTExZWYtYWZiNy?=
 =?iso-8859-1?Q?1kNDgxZDc1MDZkZGVcYW1lLXRlc3RcM2M3MGI4N2EtN2ZmYy0xMWVmLWFm?=
 =?iso-8859-1?Q?YjctZDQ4MWQ3NTA2ZGRlYm9keS50eHQiIHN6PSI3ODYiIHQ9IjEzMzcyMj?=
 =?iso-8859-1?Q?Y0MjgxMTEwNTYzNyIgaD0ieVpNN3dyUjVDUFV1NGJuaTB1NmZnVEYwU1Bz?=
 =?iso-8859-1?Q?PSIgaWQ9IiIgYmw9IjAiIGJvPSIxIiBjaT0iY0FBQUFFUkhVMVJTUlVGTk?=
 =?iso-8859-1?Q?NnVUFBRW9DQUFCbHNTNy9DQlRiQWRKS2E2aXM5K3RIMGtwcnFLejM2MGNE?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUhBQUFBRGFBUUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUVBQVFBQkFBQUFZUFRJMlFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFKNEFBQUJoQUdRQWFRQmZBSE1BWlFCakFIVUFjZ0JsQUY4QWNBQnlBRz?=
 =?iso-8859-1?Q?hBYWdCbEFHTUFkQUJ6QUY4QVpnQmhBR3dBY3dCbEFGOEFaZ0J2QUhNQWFR?=
 =?iso-8859-1?Q?QjBBR2tBZGdCbEFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBRUFBQUFBQUFBQUFnQUFBQUFBbmdBQU?=
 =?iso-8859-1?Q?FHRUFaQUJwQUY4QWN3QmxBR01BZFFCeUFHVUFYd0J3QUhJQWJ3QnFBR1VB?=
 =?iso-8859-1?Q?WXdCMEFITUFYd0IwQUdrQVpRQnlBREVBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQVFBQUFBQUFBQUFDQUFBQUFBQ2VBQUFBWVFCa0FH?=
 =?iso-8859-1?Q?a0FYd0J6QUdVQVl3QjFBSElBWlFCZkFIQUFjZ0J2QUdvQVpRQmpBSFFBY3?=
 =?iso-8859-1?Q?dCZkFIUUFhUUJsQUhJQU1nQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUJBQUFBQUFBQUFBSUFBQUFBQUE9PSIvPjwvbWV0YT4=3D?=
x-dg-rorf:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|PH7PR03MB7461:EE_
x-ms-office365-filtering-correlation-id: 584a2551-694b-4d7d-49cb-08dce2202465
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?PpoT7aTbE9zrNBuututmYb1wE6bh5MwtjiEYm8flgLPFveoADW5bDe6Jeg?=
 =?iso-8859-1?Q?jVbKzeO82b0EpdykGj8FY0vaShhuRavd7cg7NVtO4COQxWMiTdvvRjt2Er?=
 =?iso-8859-1?Q?Hnn2XE9Ur4EwMVV50wQskx7ige7ksPtKeKQJYsdpQo0st+J4JfLzjb4Xdp?=
 =?iso-8859-1?Q?R+aFO1QaN7j3BmkGfr525jK06lb8dzQu0cWv9NC15N+YOUb6wlAFJm5dIX?=
 =?iso-8859-1?Q?Cl7Tf6To+OfnRpbrJ2WmwM3Sw3NsqmdEDcudZO9gABpPqcPyqsNqPgbccF?=
 =?iso-8859-1?Q?3HnJzOb80gCRFvwmIkgke1BIcmZ8RvtpJgTxsR4fX57Jbd1AEuifF3UGee?=
 =?iso-8859-1?Q?Tl0iVwF6UrMEFtunqFCuANsVhjYN1mtf0c6LfuUlHZCKR4Zd3pYtoPrH5c?=
 =?iso-8859-1?Q?5d+4Ei2WmM5Zgxd9gm7KhK2Y9uw2jNNbFX0/ulg7C72TQPf0wNn9HnaduT?=
 =?iso-8859-1?Q?v01V8Wo1oLLpGZHnzDpoRtGbeVugzprcIASWMiCoo1X336zNdiJ6YQmGW3?=
 =?iso-8859-1?Q?cSHWfdz6CPxjV0gV1/Lc8TyJkoX8ZBXydrNgYr2Hj4PEN09tcNvrCCBjyI?=
 =?iso-8859-1?Q?8JsfTWV8TH0/KZxCvNEKPq4AqLlJVz7Ce6+QsDm1GUMpyhw0sEuBS6d6NC?=
 =?iso-8859-1?Q?obaNtHS9R+tJjErBhPA8ofENWGvWEnepRqXznuoRF9oRJ792VtDlv7mZ2H?=
 =?iso-8859-1?Q?+m63s84LJ55swiEXiq83b/PdpPMU3c4OCitOkL/dAOkix4zF3FkkIzdBk8?=
 =?iso-8859-1?Q?WLcXu9YyDrItrbkCx7rOoFzwUVTjX4bOkmx4taj1NweoezBJoTSw3t4D8N?=
 =?iso-8859-1?Q?aIoK35V8grjMe71gw3/vDfZLdAaIfszo54L4NExK2zsdsD7UBTOf8HIQ2w?=
 =?iso-8859-1?Q?KFElU8C7sfSu5HigLBmwCWqYlqfcZOATa3/u2rVfD1xUw7ZY04/dEXgEMb?=
 =?iso-8859-1?Q?+WhnIVSOcFWBgQYk2EZSwqmZob+QaVeFWVONYOWcqETfx1dy6JkFquUXaU?=
 =?iso-8859-1?Q?pwF66f646Lzioz1K4IAA0jJXqtcIGcp/QiOgltmCmx/kHQxv/6mKgI6851?=
 =?iso-8859-1?Q?GUNxCS/fzRSht7zjYMmEGRXva1CHcFvXssnwe1aW26vlaNrSB/knNkS8PS?=
 =?iso-8859-1?Q?OMqDfsDGMs8q/+LZBjpM1biZRGcStWayEdf2w8/k8ibu1yrKcEEV/GvtPh?=
 =?iso-8859-1?Q?BrzcSOAxeKKfjuYA9ifwVrkeefbbDT+6NFr4IbYOX6yrmEi4Ine4AG3NAN?=
 =?iso-8859-1?Q?n1ImgTFFqac50i/b6H5SI/GXhXwjcWLHFp7N1d3CWsAy9CxmCWflysWScU?=
 =?iso-8859-1?Q?St0davfli5e3piNQllDIbK3HPRHCj0+onPTliWEVwExItCzjDT258/2oSI?=
 =?iso-8859-1?Q?y7F0Ij1aXfMdYsm+kA/S2kBRA1WhTZOQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?Xb6RrHmX7Os+QVlrEhvfJSlvrfkGk6iVeFVI5aWZ1WWBGQYeWGjRrYcPe5?=
 =?iso-8859-1?Q?ygFWNGRTht1WgVD19ruzbysOZBhCNZAUvOqirHgj+lTtHVNQcFJhGli7WH?=
 =?iso-8859-1?Q?G3ZNQel+MJQmF/WVYrkUc5eq/PpUJ/u2jf1QFYCqymCDKx9aE6hWBhB/AF?=
 =?iso-8859-1?Q?dcvCRJ4c8c2OIY044BTp4iiVFiuXEoNreRNG4OWzJGISTE//op7gqNGnqz?=
 =?iso-8859-1?Q?z+Lo1drjckBLp6InEPFosHBJouHI8pfQxsBKDYy8+rOU/BkB9jazyrmxDV?=
 =?iso-8859-1?Q?/Ms/qXnZX5fSnmcnRdZQC3Col4MGd2ArP/Eq5EwKc35XE/DzckR+WupdPr?=
 =?iso-8859-1?Q?XXoSsmh0B/JDu/1G6ESxRUkweE/2qsqpgX0FpK1bcLNf+B4qfWGaRm0iBI?=
 =?iso-8859-1?Q?4LYSl5fmuAXONvaRX0+lz6zcQAipHvF1bzdJTeicR8ImkclYLcwCDx1eYh?=
 =?iso-8859-1?Q?iC4VI/6g7MXTzHrRKh09tefPV/8Dy+c0pNzhWcr5GPj7yqOxZQL5xZGOdB?=
 =?iso-8859-1?Q?ZH6x1hWQeyMuuBU199iaeGIHyxsCWu2eZ6EGIE9+bBPUC+N6QT61ffE1Nl?=
 =?iso-8859-1?Q?ZRA04TxBcXNHcLF49/0NeBPucfsW9pkhw53fILbtEUoK1mDnbH4Y45AAWc?=
 =?iso-8859-1?Q?VT//ofM8WwdUesamkO0vDfqHi5bA/3cZVRDbfD05XHCjeoXQF1XRNdQDkN?=
 =?iso-8859-1?Q?Kh/AvkZO2Bl8Wuvl45CtI+sCcYL9d1CiOezhGaTp3mvn3sCM2dL+Cm/3iY?=
 =?iso-8859-1?Q?6ulj3JFf0j6gUrm/j3bHBr991qMjr/rAvlPEql8BGeuf3dkrE6TuJu4Lyd?=
 =?iso-8859-1?Q?3ptfzwOqMNYZXsdG7VOyAggDk+RFnGyn94tLhLL+2f3deV/NUDUGfsC+tR?=
 =?iso-8859-1?Q?IkDMuQ5GawR8NEGPzIpdrUEFnk1mBb4mJ9IR1ze8imD2twX9bYxfOzgaiZ?=
 =?iso-8859-1?Q?XM2CMLKR5kAzjZb1oikUlOhhFJ1hHxexQqcR/VmLD8iCQM05u24eNnz81v?=
 =?iso-8859-1?Q?GRziaeMxefQ5kJTN4krsffXxa6rrsnjJg83lq9zYM9eCYth/zD0SWnWhZP?=
 =?iso-8859-1?Q?NsfmhoueWJ4LQbf38/gvI72plxL19uJgBKv3r+giFWPX5c3ElpbUI+1g+p?=
 =?iso-8859-1?Q?WLHsQE1be2UKCKZ7QazkYHUuGMRLLM48awauoyNOJ5RiegfL4W9bQmQ8a0?=
 =?iso-8859-1?Q?KCkkZzdlm/dM7ZVHpQadWGaEMYzbqTw5IYhJwGWcV4I/1aeP7Za1Vs0inJ?=
 =?iso-8859-1?Q?QPLaZcRTUBBAjnnU2T579o4eab0TJF0ALd0m6V0wcoEmG4wZYpS5v2okev?=
 =?iso-8859-1?Q?AqdDCVrJcsQcZUF/Bhj74LKIWt/EWYA+/lUMw1ZIO0IooP4+hBthsp+jSw?=
 =?iso-8859-1?Q?+J2WUdUOKd0S59DvEgma6dugUUW4XNCECSIbqe+slOiFQTcugTgrMjMAUJ?=
 =?iso-8859-1?Q?Vn8qYWeZjn3KPiKRvHJWmZpr9/3iH7MDQAgpKAW+Hx93snwZfFBocmJXYI?=
 =?iso-8859-1?Q?VZ2pU4dfxINzoxaGi4ITD8vbR8WspDYELSXVMotBWw86FvagHAWHI+1vDP?=
 =?iso-8859-1?Q?TV/bgXADxFXQwam70cTws28Cgh3TlxIaNREbKOcpghbclTNQmCr1RGGdLs?=
 =?iso-8859-1?Q?FPu5NemJgdd6w43jF2R2jYCldCR4BPY5okjqtJqLSCpK76BtYmwYxb7Q?=
 =?iso-8859-1?Q?=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CY4PR03MB3399.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 584a2551-694b-4d7d-49cb-08dce2202465
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Oct 2024 13:51:25.7040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CzTWGg50fLTez5+xEOolMyJ2yDYhUA/GIgHXpfYdaqv8CFopNpuEYuBfEEqfemZBZArPg+OYMtO3WXxS1JiO8C3ujtjmCZFpJzKEiY49khw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7461
X-Proofpoint-GUID: ThECf5R3sgwFYsb1pfDWMwBs0fZHh-_a
X-Proofpoint-ORIG-GUID: ThECf5R3sgwFYsb1pfDWMwBs0fZHh-_a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 clxscore=1011 suspectscore=0 phishscore=0
 mlxlogscore=834 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410010089

> > Regarding the bulk writes/reads, the msb/mid/lsb registers need to be
> > read/write in a specific order and the addresses are not incremental,
>=20
> We have _noinc() variants of regmap accessors.
[Miclaus, Antoniu]=20
I think _noinc() functions read from the same register address so it doesn'=
t
apply.
I am reading values from multiple register addresses that are not reg_addr,
reg_addr+1, reg_addr+2.

> > so I am not sure how the bulk functions fit. On this matter, we will ne=
ed
> > unsigned int (not u8) to store the values read via regmap_read, and in =
this
> > case we will need extra casts and assignments to use get_unaligned.
>=20
> --
> With Best Regards,
> Andy Shevchenko
>=20


