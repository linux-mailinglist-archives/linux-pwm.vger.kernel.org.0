Return-Path: <linux-pwm+bounces-8418-lists+linux-pwm=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-pwm@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OqyEBlFymm/7AUAu9opvQ
	(envelope-from <linux-pwm+bounces-8418-lists+linux-pwm=lfdr.de@vger.kernel.org>)
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 11:40:41 +0200
X-Original-To: lists+linux-pwm@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A819D35857A
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 11:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D1EDD3033E5B
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Mar 2026 09:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1654A3B47F0;
	Mon, 30 Mar 2026 09:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="PXdLMXnb"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B89D3B4EA0;
	Mon, 30 Mar 2026 09:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863324; cv=fail; b=Tuvka4g1nfb7K1I1dAR+zYGIHI4vQbTvht9hIOBu5TQN6SwLD8ke9Z5T9xd9CzY421VOqUrRQ/n5Q/nan+SRnguTS6DW36T5XkFDQIDk504CRSOpsn4j+DZQPViVPONS0jy/5Ls9qf1XpkUH3GxIdwV1oKIGrdGEUDqhojxAW2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863324; c=relaxed/simple;
	bh=HUWgwk3IAtS1Ist0ogGzp6gWGKRnTa4lMlMjHOWRDFg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YFl8+NkKbmQagJJIBmOQRNZLK8U/dJFn+Pln6DfwY5RjbQtPMw7rGV7j+HGX7XT5LJpCrGwmeaD5uen8jTheZ1YHfYH6LzCShVpI1EORTsltxrhDQHUWKjMKTu5kzhnuXmJWBHT1imb59l7rF0uwbheMdSfr5IymBF2ZxwqJv8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=PXdLMXnb; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62U3oXOt1544752;
	Mon, 30 Mar 2026 05:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=HUWgw
	k3IAtS1Ist0ogGzp6gWGKRnTa4lMlMjHOWRDFg=; b=PXdLMXnbCggdFGsLT+ZK2
	yzpwfkinpvFpxuCPwhaFh8WQxQOdJDTk+TYUCFIfwrBlp7CUov35ni6iFAmt140J
	YJ3ZI8qYVu1yFil2TDx0ljaSMP+pLdQX3j40CxGQrNFdeXGSzVNz2jy+SU4w0xlK
	XNo4DGH+VV+R2lx2OKu2p1trOh0wMgMj7SGgw16DzR12STmEjgMzsRFfFYFbd0kf
	K0DN+LqnS7DIDJkqjbxhdTpdr5p6LbGrRc6zX47mX9RofMy9SoXQjwtRe8fHGpO4
	yR+kW1J6VCkb7RzsbVfHE0YU7Z+SCtrQj4kqSvYxj+ajHbY7HI9W6dA+Gm5Uu8v2
	Q==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010053.outbound.protection.outlook.com [52.101.61.53])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d6bw0xayk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 05:01:42 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kM90zVKyiCjdtz3n9hva0Env/dp155fmP8lZtz7Lpmvm+5lrYlHd3c/UhtPEvT9pMZ3ZY0iEv8ERi6d/jRlMHKTvlb0d0+Ts7D2bNb12XJ+HcotNqGotneYabB6LVWda1ol4wSOT0DrbWOte2WUlZjBeMgRNectYlz57Z6K1kwver//wFV1XDLEALp51aE+3u5PENec5fSTA4P9kHOkqF8IC/eJiCOLGZhcGnwSKWhLNA5A3SDXe7HxiKNL8lXcRnuI7/gwlYCjK5fyP/WYJshutX68NqJn92VcN4YSyiP0p/RSfmFd+qfylCjClA095Gb/zCaNM2GFn45I9Aqe39g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HUWgwk3IAtS1Ist0ogGzp6gWGKRnTa4lMlMjHOWRDFg=;
 b=GkKOq08F/ljHETPfYQH2vFGGSKlVVVqXbHnIQ2ZHkjUchUvSJ6JDkJmupUqjjBUQbDeXB3v1mU/8jlQAPWSlJwE/6iU77c+ZG3qu6UjHpM2BBGnLL5zSF9TI7zkYXV20eH36lkuMH1gHc9bpYiT+CjuP3vtMBlw459IIwyXVFD71syU4kf/FqNcVVt7U/PMK57RLhNNuZfrG9xOo2DTUESQLLZVeYChrucWu3oAKRhXWIfZcAQaxJYdMch7DN91dZy7bx17McJ5rvxTZlQuVdlYSyi4L2+l6Kog5xNWDVWjtL1erQBWSvU9P97tPSl5GU0iePMJ4gpW6iWuKSuNjEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by SA6PR03MB7901.namprd03.prod.outlook.com (2603:10b6:806:42b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 09:01:33 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 09:01:33 +0000
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
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jonathan Corbet
	<corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: RE: [PATCH v5 3/4] iio: adc: ad4691: add triggered buffer support
Thread-Topic: [PATCH v5 3/4] iio: adc: ad4691: add triggered buffer support
Thread-Index: AQHcvdoCYYx7SyG/j0GTkPebZECJoLXDsxoAgAMW4fA=
Date: Mon, 30 Mar 2026 09:01:33 +0000
Message-ID:
 <LV9PR03MB84140648A5AE86E6A118941CF752A@LV9PR03MB8414.namprd03.prod.outlook.com>
References:
 <20260327-ad4692-multichannel-sar-adc-driver-v5-0-11f789de47b8@analog.com>
	 <20260327-ad4692-multichannel-sar-adc-driver-v5-3-11f789de47b8@analog.com>
 <324e16aba4029ec4679f7b141c5f58e8929a0da3.camel@gmail.com>
In-Reply-To: <324e16aba4029ec4679f7b141c5f58e8929a0da3.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|SA6PR03MB7901:EE_
x-ms-office365-filtering-correlation-id: 4de13af3-e467-4023-8600-08de8e3af0ea
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|22082099003|18002099003|56012099003|38070700021|921020;
x-microsoft-antispam-message-info:
 Z91iQMQKEbT7NmpUM9miItujeT2aAcR9wsksGLpkW9188VVx9swR2Uf9puFs8mr0pGTar1BohDGMylzJyu+OKHIMxb5lgEPwP+dMrmGxTLJZ2KZbsxYbep4R1LW2Z5ZihMoVIuC/UyApdtp7uHHWsFOW+/Bd3kQmDiscVjnS1TuNg3BPUe7NNIdalIpSkajyMJRkfb0AB8aUzepkPenuDqCh02a7XeNl+eofw0p1IqsWyEEwGjsc4BxeM2E4ETqbF1ABnrjG73SiVCjzouRgH/6O2mDK8QtbnUdatA1lVF/iV41WG7BoLbWFKcoFS/374IT4WHew5oGwjCwTpc5IYHTRyRaXEAof7rEznofz0lfSPn0NmmxD7yYu1i79WMtYBqmC2u3qGjoTFGjpBTogQNDnhLMfM3k30nGtvgUFQoFzHYIp/OcEVtL8AghDGODyJK35StZLevAOIslsxryGaUSHEn0k8GUDngQNb7dssVyH1kcKHD6IwKxatiZzs7fjIojFv1Bg8ZzH87j3NLBnS8k8FZTLDHcwSUXZ27NRuBy98J92HT/Ha+0LVNEwZyX/4/IuemyV0RSz01RHAjXp2I+PbFTzXZlVfom+VF0SkbCXsCh7QqX6jsSMEZTxF5+97oTPjsJBkw+ZRHfw1CwDBAJWAZSHQ4NKatwlqAFq3a9O+PJlJG/Kx3eH+91o8dOBCerNOxACb3aSGJ7EvYHL65Ksmws9CZVhhbuvTh8A0vuM5P/wwLreEc+/EvCbfPvdSGGVFBfJDhCEdF3nsJUjuZ8mCFLx5zYzMlFomE1putysoRTNJn+q6RGV21D4Tn8X
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(22082099003)(18002099003)(56012099003)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NmlKcktMT29xQTJzU2tuVURHWE9BcU5EcTFEQXJScjhweUJ2TDdjNGRnSU1K?=
 =?utf-8?B?dkMxMUdnY0JqdUo2a3Y0T2FScFNPV0p3ZnZuMGdEWE9DK1M5SzVOVVVKNGZY?=
 =?utf-8?B?QjdZb0NsOFpKalhSWVJKeGNTUDh5L0MvRFdmWit1NmNZTWlGSGJzbXpVMUd5?=
 =?utf-8?B?M3NqUEl6SFM0RUROTFVwR1U1VmhuS1VmcERON0ZzZUFlMDhVbmM0NHh6ZHNZ?=
 =?utf-8?B?bEJ1U04zTU43Q2RLVU1SeFF2MDBnSzV6cGpqNnkwSDhDa3BJRUJvSzZZZEdP?=
 =?utf-8?B?WG9TZ0RYNDE1SGovZWV5bk1YbERtTmtobVJYeEpvRFlPWWgyeVlTWWpxV1RC?=
 =?utf-8?B?OVQ2UXlnVzJzMThLYkZPa3F0dHp3WWxncCtTWVovOXJyRDl4NzhXUDk3Z0VD?=
 =?utf-8?B?ZGhaZmVMU2RGeDg4azRZWU1veFI5NmJUSGRZYnd1VG1SY3E2NTJJOURLMXgz?=
 =?utf-8?B?Mk55L2hDTThvRWIrSzYwdGdwd2VMN2laWCtza2ZpbkFTcTlialNZUW5UMG40?=
 =?utf-8?B?bG45ZTdCVzlyVXQ1d3hlOCtaemtNYWc5SXh1TkxPTjhLTXV4bDBZa3QrTkpL?=
 =?utf-8?B?akhlMnRpM05jWlBkZktxYndFYjVhUEFWMk43cHM1RHpjbU15bjllMjdNZ3pV?=
 =?utf-8?B?Z3lHdHEzTTVHVlhVTzlNbTB3aVl5SVdXQ3p1bTdlUU81S2lhdTdtejJPdThI?=
 =?utf-8?B?VG9DZUxpc2hLVnBpd3hPRnRuejVscTJCdHBTYkZwTnBTUFZrT1k0bEFUNHhk?=
 =?utf-8?B?Mzc5dGN0WEh3VUV2aEl0V0FQeWhFakpzb1dzMkRyNnhkMCs2SExDckxGSjFw?=
 =?utf-8?B?enRiZzJpNG9UZWpBQlFkSlUzaTl4ditlaStoOUFRbkRSVitpV3hyalJBVkpt?=
 =?utf-8?B?OTVRSGFTcmc4NytUVkllZFdYa1ZJUkFaMmMzK0ZKcy9aTDA0ZXVCbzVlbWVk?=
 =?utf-8?B?bGJhUGJsOUtPTnNSdmdIU0kzNnNhc0tOc3E5OS83S055MHdiQXU3U3lVWllm?=
 =?utf-8?B?dStFM2dvWElDcThFcFFueFN4T3RrSFRkcU9pWDZLWHRIeEZqbFRRY014SE9n?=
 =?utf-8?B?cjJXaVh0ZUV0b0tyRnNhZmUxcWZVSnRld2FIeXo4eEg4aWxVU2t0c0ljbkRO?=
 =?utf-8?B?bkxMWWl2dEVzT1pCK0VsL040U2tqdFdoQXk4UmhIQXJKUVBUWE10c01paVhw?=
 =?utf-8?B?L1FTUDBNNzJIUzBkKzFLM253K21VR0VMMmkxV0hqOXgrNkp4Y1gzdlZNRWpx?=
 =?utf-8?B?S1pnajRsaEFodVNUcnJoZmZVM3ZNaUZ5cXVMcXJVaDZ0MzZjb3RXTjVLS2s4?=
 =?utf-8?B?NGRHWml4YSsrcDJ3cEhPaHBXbG8vcWt5Q01uWTErMUE0L2ppRmhkc1ZQQ0Ey?=
 =?utf-8?B?b21wVzIzY0krWEJYZENVcnJhblhoNENMb2dsUGU0MWVkNE4wb005N1M0VjAw?=
 =?utf-8?B?a1FpVnhjNmVPc1lEV29lak84djAzMmJkR0xwWjdZOWFEdVlyZkNMSDNmdUlq?=
 =?utf-8?B?TGttL05LSWNZL1AvZU9iWExpTXZIYWFzM1N4OWZvZ1dLNXREb1RLOWtpVnVZ?=
 =?utf-8?B?OVRXQ1ZybHQ1MW1CNkJVL2ZtdE9MRTRXVzFudjF0SVZUU2RGQWJ5OWI1bEZs?=
 =?utf-8?B?WTVUR05Ha1dSY2hML3FkMmk0WjdWTHNaMnBUdXFxMThpdm5aUC93Rm5HVGIr?=
 =?utf-8?B?WGM5eFEyTzR3MGU5UnlOVjVSZi91L0FHdFZiaExnVjRGWXZHRFpGeW1EL3Bq?=
 =?utf-8?B?WHgwdmZDRjl4V2ZETlBWbFcyOW84aitHcDFETmpKNWhiSHhGYjExb0RCY3BJ?=
 =?utf-8?B?cHp6TlhqeENMbjhIQUVBOXZ1Zkx4b2VLb2ZnL3VYTHVKUEJCdVp3UkVOMVZN?=
 =?utf-8?B?OHRUR2VEdkhiMy9pR3FweVRZYnFmclRORk5zbGNwREFxMnhMSFE1ZW8xeWo5?=
 =?utf-8?B?ckdzNFNPYXZVVnJHWUJOLzhXaXRJcjZmRDYvVTd3ZDVlamxNbkEyRzUyOVlj?=
 =?utf-8?B?cENMUVV2UlZZMzZHWnNqMnMvT2NNVVo1VnVQeFVSNkxZWU1KRXRrRWluRHU4?=
 =?utf-8?B?bDRKd3RDV1JFVXlGVndiRlMrWmE5ZUJOUVJPSml0aWZCK09WRTI1QUFXQ3ZY?=
 =?utf-8?B?MFpvdmRrN1dTZVlsN3hUZGxUVlRNTDdZeHFXZjVNaVZiek0zeDFSektkdjhC?=
 =?utf-8?B?dmdRY3BzbmVvMUl1a1R0RnV4dk11M01qdkpUVWZpZ1FKcE9PQzVyWUpwTHI2?=
 =?utf-8?B?dTVvWmlNWldFMnNZc3dYYUFLZHJMaHhYeWIvNSttcElyQ0tJTm5Wb2dxQklI?=
 =?utf-8?Q?Ve2ryWdZ7L1/ypYp2v?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	aeJ8LjaLwnQxQK9cOW2xPrp6HrnBKQlcN5CXC0pUiN4zmHDBAqiDlw/cOiRrEFYfDeGf0lOSvbZyDEoh0EBWx79Fc1D/01eQ95yQVf++89t8j1EP0Wl4esdgzyZwjuI8YEAzCsrsk/MLO7Vc1shCSjgyDSdW2SgY/hkQuDO9jXzTX6XmADbOBD+U3U1qnhPDPJbmty+4sUjmToJtDy3Jw0vYIGnRrIGPJ+N58dcGhbEWutppuwMbVW6k16HmnDSXiVhX2UNQ0mecEu3XtMr3LQLAOiC1mE99OjQoFZ4OXy7Koi2MCwF/2HNH52X7WO/7VYVYfZUYnK7J45ubkcvvkg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4de13af3-e467-4023-8600-08de8e3af0ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2026 09:01:33.4240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tMaWWg+ERQggZAnViR1t+Xl658krNQ987OYVmnlAeX6BpMf2ec9Twuu2SsTqg/k1GeKDq5DQGpIuW6urCVylZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7901
X-Proofpoint-GUID: aDyje9zMw1whqh5qtmliiezeEH19xpsd
X-Authority-Analysis: v=2.4 cv=BqyQAIX5 c=1 sm=1 tr=0 ts=69ca3bf6 cx=c_pps
 a=ynjcjXHaqbEn4NYQb+mZsg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=pGLkceISAAAA:8 a=gAnH3GRIAAAA:8
 a=eQJ37b5lo8ebUaBu7agA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: aDyje9zMw1whqh5qtmliiezeEH19xpsd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA2OSBTYWx0ZWRfX7LeOqndLr/jV
 5lAM+ofklzx4njeBugj/ArlYWhPWPifIOkbWjlTEPjAYOKocrXuI4NSvEeYCRHkd73wOnhrEeOX
 e+l8f42rsnue2UhTMSE/IMdSnysdnFlNdfegA6wwg0XEfTtuaF53GNNAQW6xOiV1E/i79UbWMPM
 xYh3TfUxCfQT3IublIdq94ZwHWufy4REjZOc0nPCf+8beaxrhQLhlBTRFMcMoyapvuJK85KnGzt
 kPJJ10xdtYHXfa7g0HQ7muq0TkekY+BgH1zkHv0gv33aK2Vv5y4bmuluVzk0P9nVUIKPSwXGYRC
 WnafwYXYN8V2JwzAosTkLlsLqjP2Kg25h9qg1XSe7I8JEhvrmauq//68Y7bua1hUeTrwJ4nrWhW
 XSEPszlsnbc+lAuGD65fO43z649c8kmFhF75qgVZStvxeeEqP8AuEupq3NavrcMryRtfm4qfTm/
 bnwoEIuyoOhOjs/agDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300069
X-Spamd-Result: default: False [1.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[analog.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[analog.com:s=DKIM];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8418-lists,linux-pwm=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,metafoo.de,analog.com,kernel.org,baylibre.com,pengutronix.de,lwn.net,linuxfoundation.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[analog.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Radu.Sabau@analog.com,linux-pwm@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-pwm,dt];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A819D35857A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTnVubyBTw6EgPG5vbmFt
ZS5udW5vQGdtYWlsLmNvbT4NCj4gU2VudDogU2F0dXJkYXksIE1hcmNoIDI4LCAyMDI2IDExOjQ0
IEFNDQo+IFRvOiBTYWJhdSwgUmFkdSBib2dkYW4gPFJhZHUuU2FiYXVAYW5hbG9nLmNvbT47IExh
cnMtUGV0ZXIgQ2xhdXNlbg0KDQouLi4NCg0KKTsNCj4gPg0KPiA+IC0JcmV0dXJuIDA7DQo+ID4g
KwlpZiAoc3QtPm1hbnVhbF9tb2RlKQ0KPiA+ICsJCXJldHVybiAwOw0KPiA+ICsNCj4gPiArCWZv
ciAoZ3BfbnVtID0gMDsgZ3BfbnVtIDwgQVJSQVlfU0laRShhZDQ2OTFfZ3BfbmFtZXMpOw0KPiBn
cF9udW0rKykgew0KPiA+ICsJCWlmIChmd25vZGVfaXJxX2dldF9ieW5hbWUoZGV2X2Z3bm9kZShk
ZXYpLA0KPiA+ICsJCQkJCcKgIGFkNDY5MV9ncF9uYW1lc1tncF9udW1dKSA+IDApDQo+IA0KPiBE
b24ndCBsb3ZlIHRoaXMgbGluZSBicmVhay4gSSdtIGFsc28gYSBiaXQgcHV6emxlZC4gSG93IGRv
ZXMgdGhlIGFib3ZlIGRpZmZlcnMNCj4gZnJvbQ0KPiB0aGUgdHJpZ2dlciBjb2RlPyBJIGd1ZXNz
IHRoaXMgc2hvdWxkIGJlIHRoZSBzYW1lIEdQIHBpbj8NCj4gDQo+DQoNCkhpIE51bm8sDQoNCllv
dSBhcmUgcmlnaHQgLSBib3RoIGxvb3BzIHNjYW4gYWQ0NjkxX2dwX25hbWVzW10gaW5kZXBlbmRl
bnRseSBhbmQgbXVzdA0KYWdyZWUgYnkgY29uc3RydWN0aW9uLCB3aGljaCBpcyBmcmFnaWxlLiBX
aGlsZSBncGlvX3NldHVwKCkgbmVlZHMgdG8gaGFwcGVuLA0KdGhlcmUgaXMgbm8gcmVhc29uIGZv
ciBpdCB0byBsaXZlIG9uIGFkNDY5MV9jb25maWcoKSwgc2luY2Ugc2V0dXBfdHJpZ2dlcmVkX2J1
ZmZlcg0KaXMgb25seSBjYWxsZWQgZm9yIHRoZSBub24tb2ZmbG9hZCBwYXRoIGFuZCBhbHJlYWR5
IGl0ZXJhdGVzIGdwX25hbWVzW10gdG8gZmluZA0KdGhlIElSUS4gU28gd2UgY2FuIGNhbGwgZ3Bp
b19zZXR1cCByaWdodCB0aGVyZSBhbmQgZnJvcCB0aGUgbG9va3VwIGZyb20NCmFkNDY5MV9jb25m
aWcoKSBlbnRpcmVseSwgYW5kIG5vIG5lZWQgZm9yIHRob3NlIGVhcmx5IHJldHVybnMgZWl0aGVy
Lg0KDQpUaGFua3MsDQpSYWR1DQo=

