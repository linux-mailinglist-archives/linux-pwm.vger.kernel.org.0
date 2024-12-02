Return-Path: <linux-pwm+bounces-4180-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 452CF9DFD89
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Dec 2024 10:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0147B1627F2
	for <lists+linux-pwm@lfdr.de>; Mon,  2 Dec 2024 09:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48C11FA249;
	Mon,  2 Dec 2024 09:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Sizx5wWP"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0667F1F949;
	Mon,  2 Dec 2024 09:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733132854; cv=fail; b=jENFTJW+hhubNMn+lHg1LIsL9CZnI7Lxesonu08PMX1icvNsG5A5XciLTAOJ2/Duc0vPmy8aXd7gZgOvDxmXUdvgQYNii4mou+mzlPbS4UC1Wvk0PlSy1NNlcRmEnS4DcvTE1aKO3tg29CUsHng50vnlJq4UHpyMRhCnuUWN5hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733132854; c=relaxed/simple;
	bh=/v6Nzi6s2XJE10/CgSZXcKO+Dca66B6HUFzX6/bjuhc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NRH6Fk5NKfw7egz/fA8x077HEuWKV6BhBNm4d0wL+Pv1j7eRAMstQVeUapDbdKxqDUxomeXIcY/+SJ0tvK2MYXE2m+kIqHde6U/hGIJeoWhz1VbuWRPpqrqy3QmUt2M7Cf6stmMJ095rGUdHWlgx2jGpwNH/Rtc6rPVvFjNfu+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Sizx5wWP; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B29OI4i026779;
	Mon, 2 Dec 2024 04:47:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=LdaoV
	0/2H2JpE38Ek+TrLvBdQHaxjQdlZEvaiC19a7I=; b=Sizx5wWP6lS0mcpoLLJKB
	pwtLSN8UxQUoWtFfMPdtdiJGuh4CijJiLZmyzWILrmu6ZC7QrY0N3HnJYub7scE7
	iZe/xolKEo0uJHXWNDUptX2WzjR+MbgWhYy4l2CXD7MXeJinUbi+pqPSqqbaX3DU
	VnRU2jEh0TZLhkFEPj1XUneqsLo2ZZgl/Dkf8UsLQrNFqGOT4TeduGidDpjeGL9j
	ojpX3OSk0IZjEfSiM+TNhgwAOk//u4/ThMRGevfZzPHZ42uUgCvpDQT3BvfvvNrv
	wiPbx21f6FtFXSWBd8AVccFuBy19dmfsVzvcllK+w33f/a05baDT7ZajuA67bg+j
	A==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazlp17010003.outbound.protection.outlook.com [40.93.11.3])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4380g6f4d2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Dec 2024 04:47:23 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ym9k/TrD8eJ905jf3LhUln5RHnW4HrCouJQNORcBhv9sU1SEi3QR1POnUymkmn0ZmNgpF9CUDmyHFSS2SGBJrm2DZOplsWbeD72cYljDz1+JiprPYDmezYzsWwj/eZuTaTguJPloocY6sUcm9WkZkUaqfpW/vU6XlDMIW4mCEjlh7pnP4hch3FD8/wOPG6MW3KWnU18UvNxJTfFLmE6B6AdTbpHJVwKeDn4JWJHJmmJschM6b/Z7UOEtAOYXSd8oTDigm22J7q7I9+WApW/INwF28Xhi4AnOZkk8PqquW4ptxFqNDf+lTxZzwbHyo7u3AU/42U1+RK0/a46eRNmYlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdaoV0/2H2JpE38Ek+TrLvBdQHaxjQdlZEvaiC19a7I=;
 b=X/46szweauA58JpInZnD3CvxYXX7CTzN+20FaF86i6I1aXHrdm/8PlnSf1CFQavNIu6uL9Y3Xz5mJL7+b2hRKMKSJs5ZzsZADSaI42Vd07l46zlI+ZPIozi+Z16GKaAG+q9DWKdVxzROWuztlgQko0KW1D8zuFb4AnyR58+rcOoiCFRzfQHy22725sDM97w7HhFuOlmnTRIMbQ2LSuwsyRTqVDUmouH3eJiH0tiGAFG7CJhFZ9dqaUy/6KGTFjvPUU7L+2fEyquZ12uLNXkzq2M3S6N29WEgj23j1+pnHzJhqJVXlqO5/Cw46HILO+Hxub1HxhQcxpPYCkp8T9P4nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from CY4PR03MB3399.namprd03.prod.outlook.com (2603:10b6:910:57::13)
 by CH0PR03MB6178.namprd03.prod.outlook.com (2603:10b6:610:d1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Mon, 2 Dec
 2024 09:47:21 +0000
Received: from CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17]) by CY4PR03MB3399.namprd03.prod.outlook.com
 ([fe80::6504:9615:dbab:cc17%6]) with mapi id 15.20.8137.018; Mon, 2 Dec 2024
 09:47:21 +0000
From: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "robh@kernel.org" <robh@kernel.org>,
        "conor+dt@kernel.org"
	<conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org"
	<linux-pwm@vger.kernel.org>
Subject: RE: [PATCH v3 1/2] dt-bindings: iio: adf4371: add rdiv2 and doubler
Thread-Topic: [PATCH v3 1/2] dt-bindings: iio: adf4371: add rdiv2 and doubler
Thread-Index: AQHbQnQq0niAj4s/T0yYjCevKGPL9LLQCAcAgAKv0CA=
Date: Mon, 2 Dec 2024 09:47:21 +0000
Message-ID:
 <CY4PR03MB3399CB671D685BA8164E0F3B9B352@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20241129153356.63547-1-antoniu.miclaus@analog.com>
	<20241129153356.63547-2-antoniu.miclaus@analog.com>
 <20241130163948.269289dc@jic23-huawei>
In-Reply-To: <20241130163948.269289dc@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?iso-8859-2?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcYW1pY2xhdX?=
 =?iso-8859-2?Q?NcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-2?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy02ZDJiOGQ0ZC1iMDkyLTExZWYtYWZmOC?=
 =?iso-8859-2?Q?00MTU2NDUwMDAwMzBcYW1lLXRlc3RcNmQyYjhkNGYtYjA5Mi0xMWVmLWFm?=
 =?iso-8859-2?Q?ZjgtNDE1NjQ1MDAwMDMwYm9keS50eHQiIHN6PSIzNzcwIiB0PSIxMzM3Nz?=
 =?iso-8859-2?Q?YwNjQ0MjUzMTk5NzAiIGg9Ii8vcDd6KzdlV1J5S2dhN0ZUQmp2WW9hV2F5?=
 =?iso-8859-2?Q?Yz0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk?=
 =?iso-8859-2?Q?5DZ1VBQUVvQ0FBQWlYb1V2bjBUYkFVV3hPWGg4WkpSOFJiRTVlSHhrbEh3?=
 =?iso-8859-2?Q?REFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFFQUFRQUJBQUFBbWk3Sm1RQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBSjRBQUFCaEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QU?=
 =?iso-8859-2?Q?c4QWFnQmxBR01BZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFh?=
 =?iso-8859-2?Q?UUIwQUdrQWRnQmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQU?=
 =?iso-8859-2?Q?FBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdV?=
 =?iso-8859-2?Q?QVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVlRQmtB?=
 =?iso-8859-2?Q?R2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0FaUUJqQUhRQW?=
 =?iso-8859-2?Q?N3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-2?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-2?Q?QUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
x-dg-rorf:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY4PR03MB3399:EE_|CH0PR03MB6178:EE_
x-ms-office365-filtering-correlation-id: cd2c940b-0912-4f63-7c4b-08dd12b6512f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?ShrT7YJWTfoYvGClC8IUkKBAzbGqTVt44KzrO3akvvfZxqsuHgWcqgEdn+?=
 =?iso-8859-2?Q?MkwpfzHc2rzIbeUVFfsiLAzgyfqf4WrYnf868XCqRAO1EnsoIHi+dJUKKd?=
 =?iso-8859-2?Q?9GpGMVQ/6jZ6ovgknAK/Wd4uZtDNPbqJB7E24AoHoN6HWd8MhUigDyhA6Q?=
 =?iso-8859-2?Q?Ri0Yxt2ev5moXs4Nc+f7TlKb+0oXOg00eO3AZriCjsYClDd7JedN3hvm+2?=
 =?iso-8859-2?Q?IHuflUzLbtyiscbvsL3qhZxfiS+f2/viN+2k0F7+OFascREfL5MVzYt18d?=
 =?iso-8859-2?Q?vsw+U6poMQFeS+II6REpmLhq+5h8Ck/kjJEjCXCfGSJNVyOCxvIWCMrTJm?=
 =?iso-8859-2?Q?E8WM6XGBlprlD0b9D7RmZsrrDSvg6qq+bkM3E3p1p0ioYvGfyfNKzIO1b0?=
 =?iso-8859-2?Q?ZFQ5BKEELSQZWFsjXbibaV87vdGv2m0hGM5aRoEkNlHoPzsguVqHfmPUyh?=
 =?iso-8859-2?Q?zkQ/RP10RybVgIfXJGLP1RoPLfy4KY9pmRzWk8+RJBS/xAvj69tTzlTxbM?=
 =?iso-8859-2?Q?+PolWxcmEoJVEZke3sSUXI4xXQGWV/gNV6YtB1Di0FW3fEw6DFfGiYu4Up?=
 =?iso-8859-2?Q?R9/XTWEViWFn6A6DcJY0ck8UUdxeGZaygmakWcmQ2tGyEQYcWvJptSeM0S?=
 =?iso-8859-2?Q?uvQN9/QmTWK1zzePD8RIHmwe53nvnIT6VPmrzkUEUNJT6tweiTEEXBZ1OR?=
 =?iso-8859-2?Q?gsWdNu3FQrldA1UfKxg0FXh+5rx9K2NuWjdGeFNkXC+rf994+TYoDLhAKq?=
 =?iso-8859-2?Q?u6yWYrOX7/vJghF2ECqFLSa8aJsKqsyHQ4eqYncUi7so7sp7P3rYV4Wwd8?=
 =?iso-8859-2?Q?6rzWmrWjWJWHnOpPEeT8vdy7VAi8qBFbeOmDyJVL6Q+4jkr2DSWUIE1mY/?=
 =?iso-8859-2?Q?1f6q18IQ5IPXZkzIw0RYRQGdvFm6OXzxWdoTe1SAfpzp5wWwRQiOBaWUAy?=
 =?iso-8859-2?Q?eFmo1sKb82jDu/JkBUCMgv/qyygcAeEL1dwMEw7bgn1xxOwK2+6BpKrQ4k?=
 =?iso-8859-2?Q?5ZolyG+peGl1fymmjVphF85+0s9g8GKfKwk0QMCGOygoN/MZgl9SyuVFMs?=
 =?iso-8859-2?Q?1thDz3/hfQCQwtvQcKUEsZgT4C7OnMoFq5Alr04knkldPn22oICZBSuhJf?=
 =?iso-8859-2?Q?eYxBJEpEUzEhlI0rPRnZmukw3BCpUSsAr9f+SD9rDIseUz5J6BlS9aPtj0?=
 =?iso-8859-2?Q?gI9mi8mAJiiO2l7JMqgk0gP97Ywa2YuMarG6uWY0jRNPUzarcYE3kt0QLc?=
 =?iso-8859-2?Q?K6BXfP+9IkpXnfcWyn14MLtmM6UBTonFP7ywYyN5bx95toPUM56fFWgHSy?=
 =?iso-8859-2?Q?RPWhFodzjDGoKeJqbU8gfc49q3oLk7dDeg+n/Q9J4Zdl3yncEJT5LCut1I?=
 =?iso-8859-2?Q?2c5bEQclNLmYEU9WrRv6py+4yV2DwIN1op6xX2OXdlKWWXwxk9KPlTBb3C?=
 =?iso-8859-2?Q?Eq8f3D5o3R/SfAxyWKB7Ejh00/4yG0LKjgNVcw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR03MB3399.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?prZLCq73YL9LNjNVWxOpQBRAFdwzewF/lGKznXC4/BzyMCEAJGSuKR5Mxb?=
 =?iso-8859-2?Q?0xBIeXroDL0juRGfQg91igq4sld7ypGgHseRVVW8rKpwZe0+g1lvifOMqT?=
 =?iso-8859-2?Q?5UPyq4K0u26sJVzrPV5K7B6BA5CZFyilBbk3XGzsaG2VcJ5NmcGaLIBxuh?=
 =?iso-8859-2?Q?u27tioTenLTLACiQ0z6ZHCmNhrtYa5dUIGGwKehpJhX+vNV5dzDM323HVf?=
 =?iso-8859-2?Q?e94BQka/wWmPyDPR9HyiEXqTfTo+a+DtxfGq3AAcfn6/ZuowS+j2ecVZlr?=
 =?iso-8859-2?Q?97G8iafwWjQc25QniSPVzjgRP4+HWKMXQpARDmMlh5KhgyjC7pKEA6+agH?=
 =?iso-8859-2?Q?Yky6TUCZrA784haEHbHUi9s0+miE+gm3Jyjvf2J/kFjFH+3gc9agnfxPB9?=
 =?iso-8859-2?Q?NEA+xu4Zd/SuOAL5S/AQQMtgmWYC6MTjrLCcWIwquyHRTzZ0wCLMVjZo1Z?=
 =?iso-8859-2?Q?l5N7M3GJiOnxfuKeZNWIUGq6if/FybfnQzTFJtpKhZ6Hs6zV9EBzkVjsh0?=
 =?iso-8859-2?Q?ifOTxZ4Ss8N/SACCTnsSGE2IlYhhTeX3UtBdSOqm/fzpEq8uvfvfGgL2bh?=
 =?iso-8859-2?Q?57ZH8/fYo+WmbWWItWU56oKTHqzAq/qCxiHeqqrOqaWH9CBBgqnVR/yu6U?=
 =?iso-8859-2?Q?aHrPE8FdT1OSaSyvWS7kl48YXX1XInS4qfoDFoxbtiff46fiUXmZadOcKA?=
 =?iso-8859-2?Q?tqinERDDm6x3ssQOVnReKr8Fwk238cwPsnESlaLJkS8TDvNyBSCac8fewr?=
 =?iso-8859-2?Q?Acd0bq+RMHDp+FVBsdjjRx0npKmAhpPOsbjiRzzNYd59miwqgvMV/SvEZh?=
 =?iso-8859-2?Q?vzHINlMa+lxtxryHfzolObignyms1W7Rcj3o26sO88QCheUFt4M4lfeNOX?=
 =?iso-8859-2?Q?cITCz0k8CxuvI/o94PzNvp9fDrd2x5nWtL9T5SctU0bESgzVqqVi+wBDet?=
 =?iso-8859-2?Q?NtHIQV+yjVShHf82kWj83z9I2PqKqocIq6my/OALZnqijRg/0gie0qBszq?=
 =?iso-8859-2?Q?5lOHraL01stRIqR4QU7/Grb2a3o/rEpRdsa2vB+ePGARM2s6xLweepp0ev?=
 =?iso-8859-2?Q?09Pr2jLQ1m0z/1Vf2FstKweRiBjKmD6gC5a5eiOxjgk1xJ4CwQwTrGEzfj?=
 =?iso-8859-2?Q?eBRxxrV6sDNEs5Ar++OSRd0hwuc6ew+f2PZBzznJJVpGBvTtMgJ/FveMFo?=
 =?iso-8859-2?Q?GZJW+e4fvSb7o0Ux2KJUbx3SzIe0JT7LNiCMNPTdJ4wJA+8P5Vtyor+HhU?=
 =?iso-8859-2?Q?oltJgFxdNa4Sjy75MhSZLuUs4hXZknfeaWzYQ2KVf9PistVIChJBJ/f6q/?=
 =?iso-8859-2?Q?hYmjRYNylRsDd1M//U6p3YrASY+6+RivSDMnIiW74xQ2cAJ1/xqYIzchAp?=
 =?iso-8859-2?Q?tXN4mK/oLiXvyEwDGNtYwH1c8bFq5vbKIYxk4HVw53PptCjlCm5uXIcjX0?=
 =?iso-8859-2?Q?Bj+QDlkqVEgJ4XBwqAMxcDyBIV2wh8HyBN2Uz/LFvRR7Kl3DY+IP2GLb89?=
 =?iso-8859-2?Q?EuHkjXdT1fjrtrbfa9Ryx+PINBNsRlcgtjkmk8ttea3onA9lAU9z8bM4G8?=
 =?iso-8859-2?Q?E79EYXrwYZh/GSeNyKrGXPv4TZ8v7Pw+ADKy38BApYGIWuaMfHwXz2fiJA?=
 =?iso-8859-2?Q?JSs/NjiRj+7Gx4aUC2nsZBGh5X/f/DGRws?=
Content-Type: text/plain; charset="iso-8859-2"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2c940b-0912-4f63-7c4b-08dd12b6512f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 09:47:21.1702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fi/v8q2s7Vellog+yyKPIBRztWQrvGiVrQVYCGwYug81CeAXUPhMM1hbIO3T6ljbYemLgMF43W4KlFBj5SB8mH47wKbOpGMQUcV5XxAxSaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6178
X-Proofpoint-GUID: sAocVfrW8RIj2qr8mnKh_Qz4JCtq6_YA
X-Proofpoint-ORIG-GUID: sAocVfrW8RIj2qr8mnKh_Qz4JCtq6_YA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 clxscore=1015 mlxscore=0 adultscore=0
 priorityscore=1501 phishscore=0 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412020086



--
Antoniu Micl=E3u=BA

> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Saturday, November 30, 2024 6:40 PM
> To: Miclaus, Antoniu <Antoniu.Miclaus@analog.com>
> Cc: robh@kernel.org; conor+dt@kernel.org; linux-iio@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> pwm@vger.kernel.org
> Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adf4371: add rdiv2 and doub=
ler
>=20
> [External]
>=20
> On Fri, 29 Nov 2024 17:33:52 +0200
> Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:
>=20
> > Add support for reference doubler enable and reference divide by 2
> > clock.
> >
> > Both of these blocks are optional on the frequency path within the
> > chip and can be adjusted depending on the custom needs of the
> > applications.
> Thanks for the additional info!
> >
> > The doubler is useful for increasing the PFD comparison frequency
> > which will result in a noise performance of the system.
>=20
> So I'll play devil's advocate. Improved noise performance sounds
> good. If it doesn't take me out of range of allowed frequencies, why
> would I not turn it on?  What is it about the surrounding circuitry
> etc that would make this a bad idea for some uses of this chip
> but not others?
>=20
> >
> > The reference divide by 2 divides the reference signal by 2,
> > resulting in a 50% duty cycle PFD frequency.
>=20
> why would I want one of those? My 'guess' is this makes sense
> if the reference frequency is too high after the application of
> the scaling done by the 5 bit counter.  In effect it means the
> division circuitry does divide by 1-31, 2-64 in steps of 2.
>=20
> That could all be wrapped up in the existing control of the
> frequency, and so far I'm still not seeing a strong reason why
> it belongs in DT.
>=20
> The 50% cycle thing is a bit of a red herring as assuming it
> is triggered on say the rising edge of the high frequency signal
> to toggle the divided signal, that will always be a 50% duty cycle.
>=20
As mentioned in the cover letter this was mostly a request from
customers that are using adf4371 on a large scale and they need
these features to be controllable somehow by the user.

Since these attributes were already validated as devicetree properties
for adf4350 on mainline, I found this as the best approach to satisfy
both ends.

Antoniu
> Jonathan
>=20
> >
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > ---
> > changes in v3:
> >  - add explanation in commit body
> >  .../devicetree/bindings/iio/frequency/adf4371.yaml    | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/iio/frequency/adf4371.ya=
ml
> b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> > index 1cb2adaf66f9..ef241c38520c 100644
> > --- a/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> > +++ b/Documentation/devicetree/bindings/iio/frequency/adf4371.yaml
> > @@ -40,6 +40,17 @@ properties:
> >        output stage will shut down until the ADF4371/ADF4372 achieves l=
ock
> as
> >        measured by the digital lock detect circuitry.
> >
> > +  adi,reference-doubler-enable:
> > +    type: boolean
> > +    description:
> > +      If this property is present, the reference doubler block is enab=
led.
> > +
> > +  adi,adi,reference-div2-enable:
> > +    type: boolean
> > +    description:
> > +      If this property is present, the reference divide by 2 clock is =
enabled.
> > +      This feature can be used to provide a 50% duty cycle signal to t=
he PFD.
> > +
> >  required:
> >    - compatible
> >    - reg


