Return-Path: <linux-pwm+bounces-5072-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B7FA4E5A8
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Mar 2025 17:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28370888056
	for <lists+linux-pwm@lfdr.de>; Tue,  4 Mar 2025 16:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355E424C090;
	Tue,  4 Mar 2025 15:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="gs6B2Rvm"
X-Original-To: linux-pwm@vger.kernel.org
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506D618B470
	for <linux-pwm@vger.kernel.org>; Tue,  4 Mar 2025 15:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.115
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103235; cv=fail; b=OOJ9RuzvMoumt3TYezlI8ry7iAkT3DuhitxcDP3P+7O+PFuZ1PqUbRrW/rC87CaJpkWMt7piMHyGzB7hvGhk1V20mlmWBl27wIksXhaBLgYTFovltianwaK58idqJD2L8RlfLw2Zo2gndPu/HMxpHj7kssFntNh8xfZ10PBAD+A=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103235; c=relaxed/simple;
	bh=8gbFIxHpyCSDMy4Kkger0sH4LmUz1VMct+ICELwyN54=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=neIy2Stl//N+PrOD5DarVKetqg3alOAhEueegTjO/0Aod6LrYlCU7qw4p+aHyzQXkj1T+BTjtlVSIoIhkRIe+91njrNHaY9c2zrA/u3cuRmpE2w0r81yvQsnU2Sc9PXtas3MiBBivFU2v9t8lWoVOdoir8kp2NZXthavMkXUg0g=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=gs6B2Rvm; arc=fail smtp.client-ip=148.163.139.77; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; arc=fail smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id BB67A40CF642
	for <linux-pwm@vger.kernel.org>; Tue,  4 Mar 2025 18:47:11 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=gs6B2Rvm
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6g4S72HXzG11y
	for <linux-pwm@vger.kernel.org>; Tue,  4 Mar 2025 18:45:28 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 6E73C42745; Tue,  4 Mar 2025 18:45:18 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=gs6B2Rvm
X-Envelope-From: <linux-kernel+bounces-541847-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=gs6B2Rvm
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 9040841BA4
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:47:58 +0300 (+03)
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 86E9B3063EFE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 16:47:57 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EE807A5BCA
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9DC213248;
	Mon,  3 Mar 2025 13:47:35 +0000 (UTC)
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D394212D8B;
	Mon,  3 Mar 2025 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741009650; cv=fail; b=EkPdA0msUJ+4yspKWwtprb+FhwTZBg5X8SD0rFWNZix0YD4lauceSa9IdCG52EVJLUe2P4QNjrMlDVd2Fj7p6laUAjftb6JGID61C7m7JLbJs6Uh7qmoZ+Rc1+eKc2OfbwiZJPbi0V3UxXM+0C+qHQrcav95RL0nt42OjpnIOAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741009650; c=relaxed/simple;
	bh=8gbFIxHpyCSDMy4Kkger0sH4LmUz1VMct+ICELwyN54=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XaK6MwbEpCrrUsYaAFI0ZnxDvpe684PRMZiw1zdLcKlMC38hk5SkYyp7PIO9n07kBHXe3t3v0joL18eMcPdEs2+27ynbjdp/X2Iw9P6cwFXjeQzkNyDODhqpBcDJmXRrswlkkcR//6Ze6hdd3p2zuioLAyPa+cKB7Q8GZ3LLpqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=gs6B2Rvm; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523DfVxY004534;
	Mon, 3 Mar 2025 08:47:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=8gbFI
	xHpyCSDMy4Kkger0sH4LmUz1VMct+ICELwyN54=; b=gs6B2RvmZRt35RSF5rKCz
	ddURsOU7X7H+saRQ6YEkpOEk8lK+5ENuAUALzycxj7ZD82Z+SFVxzz1tlW6ekOQR
	bNdGCbGGLEESsLqVo/HUyCKsS926Md1hyUA1/n+X0Pn97eUSmUCyJetBnmQXgXqX
	6J2WUFuam87qExLP6xkz2VdSSedrnh6A/ntOHNEA1VJa+lSXPVbyryw7E111wf8N
	BPsDcfpYwWGzGakp5yfyna70qozlX3WLNjHx2SSvtE17pxdjQUH5/njvos/d6z8g
	4QbeTO3/zmz0vKNG3zL5GqjlEmfp0uNjzXJ29ojGgE8d1OTrcjps7JdJgKRpYDyK
	g==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazlp17010000.outbound.protection.outlook.com [40.93.20.0])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 453vvegtv9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 08:47:11 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X5J2sSHWXzC2cpEQqsAvD/SOISadg9OEuFbI82W1wwv3rWPAF6plfIEbiG2iLCajBjGXBsY5+PZ6q3q1+/65PNd4EVET8nSleHYuSU3dt0ezfpV+Ci0dFKK9DpIWpwT6hnMC4QB9d/R4PhWHq8TCsFAk6YOzqx70PLMkSMIJUPwTP3fPGTiNRrpLm3+Q5ivf4z2IzDGmhAE0Rp+wJTvgasMVSovJc0FicmUepEA4tf1FZlUilEOfNG6oeMjJqbvUgPWaZeUd5f5snw2h784NUWKpeZOC8ApsY7bv1iMyziGNZhWMD2iDhvmQMMpysN2djhNHcOELNUYEiXhbMnSh7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gbFIxHpyCSDMy4Kkger0sH4LmUz1VMct+ICELwyN54=;
 b=JcVYEr2RcUKBoiVcDBAmA/1DWzN5heKYqIGN/FgjBB3cJ2Hf7TJULLtppnaalhaxP7PYlnQK5uf1nCu4NqQGRcBHagLi0stR9E9Z7DCOplH2puWanqgtC5sfEVKH6dEIFbI87zigvWw70IjcsNjWthU6wGOPcaTh+EESJOw8m9S0u0z7SQL1DI84hAm9f5UEE77okdpn7xaNfnv8ZwNMqEMtUY6ULIXWGTT3QCqWIKB0HLOq+UtGbq4Ad1PT6nRKSGli6LwBvnR5FXcfrq8MVBDNC7Y8kpJZqyaUX1eB9G/Jt4r5/Kf3gn7+zhS/dbtl9FHdKg3WyXMKWai02Xoi4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB6512.namprd03.prod.outlook.com (2603:10b6:510:be::5)
 by PH0PR03MB6334.namprd03.prod.outlook.com (2603:10b6:510:ab::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Mon, 3 Mar
 2025 13:47:09 +0000
Received: from PH0PR03MB6512.namprd03.prod.outlook.com
 ([fe80::c8b5:7953:eec1:cb28]) by PH0PR03MB6512.namprd03.prod.outlook.com
 ([fe80::c8b5:7953:eec1:cb28%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 13:47:08 +0000
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij
	<linus.walleij@linaro.org>,
        Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>,
        Mun Yew Tham <mun.yew.tham@intel.com>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>
CC: "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>,
        Bartosz Golaszewski
	<bartosz.golaszewski@linaro.org>
Subject: RE: [PATCH 05/15] gpio: adp5520: use new line value setter callbacks
Thread-Topic: [PATCH 05/15] gpio: adp5520: use new line value setter callbacks
Thread-Index: AQHbjD7NUYp34GY7jkyXaRkXLzjYA7NhbPYA
Date: Mon, 3 Mar 2025 13:47:08 +0000
Message-ID:
 <PH0PR03MB651210C6D5480D215619C1648EC92@PH0PR03MB6512.namprd03.prod.outlook.com>
References: <20250303-gpiochip-set-conversion-v1-0-1d5cceeebf8b@linaro.org>
 <20250303-gpiochip-set-conversion-v1-5-1d5cceeebf8b@linaro.org>
In-Reply-To: <20250303-gpiochip-set-conversion-v1-5-1d5cceeebf8b@linaro.org>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6512:EE_|PH0PR03MB6334:EE_
x-ms-office365-filtering-correlation-id: 3f4ba646-7d39-4d49-b6f1-08dd5a59e48b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VDR2eWhuOFdyWlhpVFpJY3hXdm5SakYvVFJqcnFHcTZkSXJpYUNSSzM1b21v?=
 =?utf-8?B?V2M4KzVSZktvWGhFc05WNGZ6WVpkMWR3bUdmckJiSEdJYXVnamt4WTlmRW5M?=
 =?utf-8?B?c1Yyc2x2SW94UFlFRlYzMDZvYXlVSDVvVFEzN2FRUDd5ZkkzZWpLRnh6RlR1?=
 =?utf-8?B?SHkzNWJpZWdyMXdHQXRBTW1sckIvWkYySVQwQUdZcmV2dTh5NXJEU1I2TEN3?=
 =?utf-8?B?d1lIT0Eza1k3LzJ1WTZJWTNUWWViOURRVEpIK3dlakRyK3pkWm55eE1wbVRB?=
 =?utf-8?B?N1Z2RzBUOXQzNjZaSnNHNlhTb2R0UXM2ZWJvelJBSlp3OWhkTUxGb2ZaM1M2?=
 =?utf-8?B?US9JQjJXSU1DOTlVQUVFM0NMRVYvSDQrb2hSQm12bUtpbk55bGhEVHd0M2hn?=
 =?utf-8?B?ejM1Z1BzNjFHRDJWbEFoYW5FMWVlSkI5R0tZb056RnZoYnN0SzlLTWdTcmN0?=
 =?utf-8?B?WDF5ZHlINnpRd3N2UVFZRXNLRFY1dm9IaktRT09reW9OM2F2elRubWp0ZTlB?=
 =?utf-8?B?aERrL1dFUThqS3VYSGZwYVdsY3Btb0QxOUxRV0tqNDFKR1lmbEZRNjlTMkhP?=
 =?utf-8?B?QmdSTG1NTmR4d1NTQXo5aVZ1Nk95dUpEUWJsN2hEakZZb3prZHlCWnlLd0NF?=
 =?utf-8?B?RWx4ckE2VnVnSWJMc3E1YVNzTk91dStRU2M3OWN2QjVETHRuM1NpTnF3UjZZ?=
 =?utf-8?B?WUhTZ2ErTVpqVUIyZzNaZUlDbVJDbFk0dVB1OVM4ZWN2OUVOb2ptekNCdmpH?=
 =?utf-8?B?QmZsTHF3M2J2Zm0vUFNGNUJycDMyaEdDZm9ncDdEUDFlaHlMQWwrSkU1TnE0?=
 =?utf-8?B?eXFUSHpxZmNTYVpKWGNxQkhXU1BPVUFwSHJJZVlTRG0vckdUdi9GT1M2VXRE?=
 =?utf-8?B?eWF2YUYrbVNMYSs0NlpMWHRtQkxmYVgyck9FRUFzSkdxbEpPcmt1YW5INFFY?=
 =?utf-8?B?akJSRzk1OHdGVWo4ZEM0ckU2OE9SanZueTlmYk8wbDU1N1pZUlFGTGZsbjA3?=
 =?utf-8?B?UE9zRlZhbjlqaXh1NlhsK2t5UVdIVFN0d1o1VEEwb0V3RytocUptVThKbHh1?=
 =?utf-8?B?em0xNjBSdkV5K0tDR2w3RDJhazVTRWRvNThaUWJwcGo5YU95Y0tnQVltYVpB?=
 =?utf-8?B?c05KbERZWEJYS3NzWG1zeGFXeHZBaUQzOHZZSDBVVE45SVJzanBxa1RNYXlH?=
 =?utf-8?B?UEJ2QTJETHNad3VFQ3pUSUxDYlByanp2K1d0c2lxUVN5WkJYQ3gya09FL3hr?=
 =?utf-8?B?OWJHUThpWHh1NndXMXlaYlVBSzJMSWttL3IrYmxDSnJweE01WStKZmFRYnhR?=
 =?utf-8?B?QWtDMWVQTnpFMjE4Nzc0ZGQzMkRaZVNycndteEdpd2Y1S2p0Qis2M3lYYW4w?=
 =?utf-8?B?QWRJSHA3RkV2dU9WcDFXOW5XYUNwRXpINDU1RUZOK1RZSG9qc2V4Ymk1VDFB?=
 =?utf-8?B?QUhHY3l4QjlwclRseDMwZTFrVFRQUGZReHNBcktrT1BwVTJjSmUxNzkzR29B?=
 =?utf-8?B?S2hGUU9QKzI3QlNLeStkcDZyOHRUVUxxQmdRTEhkRlZSMjBUNGg3OCtQNy9m?=
 =?utf-8?B?V2pMVW40Q3hIeG1EWHZHYlJjdXhCWWlXL2hXSXMzcWRtUm9rR01KWmNCcDAz?=
 =?utf-8?B?bEhiN1gxUyt4Q21McTR3dmRZL0dxUVBQOUs4Rmw1ZjRUeGhpSFBBSHlpRkV6?=
 =?utf-8?B?dU1tbzdGbTZIUEVNZno2SGxxVzh6V1d5RjJOMUZ6aWFNTHZxeXV6Z1p3M2k2?=
 =?utf-8?B?MkhBeVlqUThVL1F3a3UyTUJwRDVqVERjQUdKZW56VzNHRWFYY25LcWpKQVA5?=
 =?utf-8?B?TWp6NjU5ZDBCUGx5ZDFFTXpDZktzWnhRc2QyUmxBVHo2aU4wWDVxZW4zL0tZ?=
 =?utf-8?B?bGNaa0ovcTM5R3paeU9veWZjVjdmczUvOC9KQStLeUZIeXg4d1NlMjlTMitx?=
 =?utf-8?Q?qEp8xiLzncw6Q/gyYLZOoI3aRzd/I46F?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6512.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d1pQbGVkUG93V1h1RzROOTBLQjFKUUV2NndzbmltY0VDU2hWUHVEc0thN3Nz?=
 =?utf-8?B?MkRlYU5YNVBYYnNzUVYrKzdDQnBreGJ2eSt6dWZMLytsOGFrMjdkaW1nRUtM?=
 =?utf-8?B?QjJ2bjZlZUd1VmRVVXFxT3RkNUl2VG53QmREclI5aEZpSGdnbFQrN0JVUlFy?=
 =?utf-8?B?NUY4UkVXaWw4UFR2T29EUmx3RzF6enF5bzVtRmtFYW9aNWhBNDJyMzF4UHJq?=
 =?utf-8?B?blFlZWFqQmk5MFZlQWJYN0tnRU1BTWx1cUpCYTJ1UjVkSHBwalI1cFB4SjZ5?=
 =?utf-8?B?cm1SZUVzNDVibXA3UHVkRllxMEpTWllBamJxYUUwRWx6NnpHYU1yU3dQdWhR?=
 =?utf-8?B?NFBOWXpkUjJYSHcvcTJPSmxXM05LQzJjNG9uclVPZGpxS05lQmhVR1Z6TVpF?=
 =?utf-8?B?TGFJN2VobUtmYzJjYlhnRGdjdGFLVzQ5dzN1OWFVazl3V2REc1BySjgwMzRv?=
 =?utf-8?B?N2JRaUZDU0dRaGxZQklLMWNEV3pta1dHZTI5bXlENTZ2YlJMSUsyam1Telh2?=
 =?utf-8?B?N0ZrWE9EK0ROOUdVTVZzaC9KUDFWV2VqeklOd041TjkrNUZjcm5sVEdFUUxR?=
 =?utf-8?B?OWxYL3ZFamRaOWNmcCtWNXdwcTA0R21Kc0M4SXoybkRBNGtrQStRZ0JaTy9x?=
 =?utf-8?B?N1FOTEFzVkZMREhTRlFrZHc2KzFDUVdzR3o1Tk80bVA3UTJDVkVFWlZwSmZP?=
 =?utf-8?B?T2REcURwYWpuWEtONW4zb2VDVVhMM1RubEZMc0w2U2dFcDAzTXNURFpnRzB6?=
 =?utf-8?B?MTFVNy9TTllWblk1K0Q4R1ZVMEc0Y0h0dHhxVGwrUWlWclNtejN0SmlRcG1B?=
 =?utf-8?B?My9qblJYUGY0Zk5XWWhhTTVCcXB4MnNJNHFoM3RUL1I1SVRZa2VsdTdMMzIv?=
 =?utf-8?B?QnUxVVFCTWhURTlDTkYrYVNmTVBZdjRFZTFxS3VJOHU1VzR6MHdMTnNSN0dN?=
 =?utf-8?B?UzZqbnJ3Y2lmS3A0OHNlWG5meHcvNjZtd1c5aUd3RkwvcXRkK0htQVlpeFNk?=
 =?utf-8?B?dWVlbDVBTHB0cFRVWjQvK0VPSGxJbWt2M0tiYkhvcjZJeU5lakhHSHlMWE1o?=
 =?utf-8?B?WHo0RUFXR0NJektkQjQrQmZic2xYeEp1RVgyVmY5ejF4MTE2TURvVFBXVXRS?=
 =?utf-8?B?cnhodGFNMmVxSG53RmovWjU2KytJa01NZzRXUzFDZklqTzNrcnpPTUNZNEdy?=
 =?utf-8?B?U213S0daTlVyUFQ2b2dCT1hyZjhueXlrNTYzQ3E3TDZWZjdDTGt2SHQ2dVJB?=
 =?utf-8?B?Z0RYRi91K3NQdXJPdnNUcWJ5bzYxSkQySndEeXllM1Zyc0F3bUJSWk1oemlR?=
 =?utf-8?B?THpmMXRoQkZxaUJqZ2JFTzZXdGFwVkFlNTBxUExyN2dtLzZxbDBUY1Z5bmRE?=
 =?utf-8?B?N3NVekNDaXcyM1gzajAxK1NKOEZUdGNCdEk4bHVXeUkyUHlnd0xBTTJ5WDUz?=
 =?utf-8?B?STZkWFpaa0I5Z1ZkcXFBb0hhMGkzOWhhRzJkNDVRUENkK2F5VkMrNCsrQUhQ?=
 =?utf-8?B?ZkU3bHRIeGlvaUgvV0kwS2VsSFozeXlHeGU5QUoyRVJrRW9HMnFYbnora1Rj?=
 =?utf-8?B?cjVBOFYxS3poKzlTamNrZTRUZ2Vjd1JMZ0xBRGVKaGRhSE1jUmE4Q2gvei9Z?=
 =?utf-8?B?MzlVZkZBaGZQc1VNb3lPU3ZSbHlpNFhxRHRsb044TkJGSW9yamc2OVYwSUdh?=
 =?utf-8?B?YThlUGZUSkwrd1Yrd0NtN0tDQUl2RDFvWTNUV0tzZHZ3V256UHNXU1dodmpk?=
 =?utf-8?B?NWFQbG8vdEgrcnZOMFY0QjlVMDJvVFdNYzkxb1h5cjIvYm9tTjJITXFLUTVo?=
 =?utf-8?B?a3Z0WmZJekw3cU9nQnJ2UUd3VndPZXVseHVaYkVRWnNQWURWQkVtOFBKb2E4?=
 =?utf-8?B?eFhORE1nMVQ0RWRKc2ZLdWF1M1cwdzhnWG9DL3F4MzM4S0ZDM3ByWk1aSFNh?=
 =?utf-8?B?TU1rRGdzT1R6N2FLeTZsVDArQmEvbUFkYVNJcExrN0h1bW5sQTdKbnBxbExH?=
 =?utf-8?B?N0kvUmVzMGRaaTAwNU1OWnBKK2NpUi81SGxHSWYzTGZ6eVVXZC81a3BZSkZD?=
 =?utf-8?B?T3JNS0JIOENDa2d3YlU2SGVJcTFpVGNTNVdURHJjdDFWSXpOeXNhVFd0dzBv?=
 =?utf-8?B?ZTlMaFNVRkljT056cUxzM0hqcXJQUzA1MVhHUHlodHh3M2F0cDhXTWxUbmk2?=
 =?utf-8?B?Nnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6512.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4ba646-7d39-4d49-b6f1-08dd5a59e48b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 13:47:08.8937
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xEHAynNfPOYj+3VCaVd+RBQb09BoMZSkcu3NnrGBytN/Art4hUrs42sge0uGtFFFyIDQE+EkizeyL8QguRISbrkHijdDGV56/eUXDiyAYWg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6334
X-Proofpoint-GUID: cAKtbi6EzIe_uE419YP3kIqjRpLP7r2F
X-Authority-Analysis: v=2.4 cv=PMj1+eqC c=1 sm=1 tr=0 ts=67c5b2df cx=c_pps a=xM7ec0glCC7UZJxDhKPaNg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=gAnH3GRIAAAA:8 a=P1BnusSwAAAA:8 a=QyXUC8HyAAAA:8 a=7KBfExy5AAAA:8 a=VwQbUJbxAAAA:8 a=w1d2syhTAAAA:8 a=JfrnYn6hAAAA:8 a=voM4FWlXAAAA:8 a=YVjOitX3pUA4POl4yWIA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
 a=oVHKYsEdi7-vN-J5QA_j:22 a=D0XLA9XvdZm18NrgonBM:22 a=eL7OMsOqQ-6kYQPn45L1:22 a=YXXWInSmI4Sqt1AkVdoW:22 a=1CNFftbPRP8L7MoqJWF3:22 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-ORIG-GUID: cAKtbi6EzIe_uE419YP3kIqjRpLP7r2F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503030105
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6g4S72HXzG11y
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741707942.26871@2udsUzMkkkqVChLyS08z2Q
X-ITU-MailScanner-SpamCheck: not spam

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFydG9zeiBHb2xhc3pl
d3NraSA8YnJnbEBiZ2Rldi5wbD4NCj4gU2VudDogTW9uZGF5LCBNYXJjaCAzLCAyMDI1IDI6MTkg
UE0NCj4gVG86IExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz47IEJhcnRv
c3ogR29sYXN6ZXdza2kNCj4gPGJyZ2xAYmdkZXYucGw+OyBIZW5uZXJpY2gsIE1pY2hhZWwgPE1p
Y2hhZWwuSGVubmVyaWNoQGFuYWxvZy5jb20+Ow0KPiBMYXVyZW50IFBpbmNoYXJ0IDxsYXVyZW50
LnBpbmNoYXJ0QGlkZWFzb25ib2FyZC5jb20+OyBNdW4gWWV3IFRoYW0NCj4gPG11bi55ZXcudGhh
bUBpbnRlbC5jb20+OyBKb2VsIFN0YW5sZXkgPGpvZWxAam1zLmlkLmF1PjsgQW5kcmV3IEplZmZl
cnkNCj4gPGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdT4NCj4gQ2M6IGxpbnV4LWdwaW9Admdl
ci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4gcHdt
QHZnZXIua2VybmVsLm9yZzsgcGF0Y2hlc0BvcGVuc291cmNlLmNpcnJ1cy5jb207IGxpbnV4LWFy
bS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWFzcGVlZEBsaXN0cy5vemxh
YnMub3JnOyBCYXJ0b3N6IEdvbGFzemV3c2tpDQo+IDxiYXJ0b3N6LmdvbGFzemV3c2tpQGxpbmFy
by5vcmc+DQo+IFN1YmplY3Q6IFtQQVRDSCAwNS8xNV0gZ3BpbzogYWRwNTUyMDogdXNlIG5ldyBs
aW5lIHZhbHVlIHNldHRlciBjYWxsYmFja3MNCj4gDQo+IEZyb206IEJhcnRvc3ogR29sYXN6ZXdz
a2kgPGJhcnRvc3ouZ29sYXN6ZXdza2lAbGluYXJvLm9yZz4NCj4gDQo+IHN0cnVjdCBncGlvX2No
aXAgbm93IGhhcyBjYWxsYmFja3MgZm9yIHNldHRpbmcgbGluZSB2YWx1ZXMgdGhhdCByZXR1cm4g
YW4NCj4gaW50ZWdlciwgYWxsb3dpbmcgdG8gaW5kaWNhdGUgZmFpbHVyZXMuIENvbnZlcnQgdGhl
IGRyaXZlciB0byB1c2luZyB0aGVtLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQmFydG9zeiBHb2xh
c3pld3NraSA8YmFydG9zei5nb2xhc3pld3NraUBsaW5hcm8ub3JnPg0KDQpBY2tlZC1ieTogTWlj
aGFlbCBIZW5uZXJpY2ggPG1pY2hhZWwuaGVubmVyaWNoQGFuYWxvZy5jb20+DQoNCj4gLS0tDQo+
ICBkcml2ZXJzL2dwaW8vZ3Bpby1hZHA1NTIwLmMgfCAxMiArKysrKysrLS0tLS0NCj4gIDEgZmls
ZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncGlvL2dwaW8tYWRwNTUyMC5jIGIvZHJpdmVycy9ncGlvL2dwaW8tYWRw
NTUyMC5jIGluZGV4DQo+IGM1NWU4MjFjNjNiNi4uNTdkMTJjMTBjYmRhIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2dwaW8vZ3Bpby1hZHA1NTIwLmMNCj4gKysrIGIvZHJpdmVycy9ncGlvL2dwaW8t
YWRwNTUyMC5jDQo+IEBAIC00MCwxNiArNDAsMTggQEAgc3RhdGljIGludCBhZHA1NTIwX2dwaW9f
Z2V0X3ZhbHVlKHN0cnVjdCBncGlvX2NoaXANCj4gKmNoaXAsIHVuc2lnbmVkIG9mZikNCj4gIAly
ZXR1cm4gISEocmVnX3ZhbCAmIGRldi0+bHV0W29mZl0pOw0KPiAgfQ0KPiANCj4gLXN0YXRpYyB2
b2lkIGFkcDU1MjBfZ3Bpb19zZXRfdmFsdWUoc3RydWN0IGdwaW9fY2hpcCAqY2hpcCwNCj4gLQkJ
dW5zaWduZWQgb2ZmLCBpbnQgdmFsKQ0KPiArc3RhdGljIGludCBhZHA1NTIwX2dwaW9fc2V0X3Zh
bHVlKHN0cnVjdCBncGlvX2NoaXAgKmNoaXAsDQo+ICsJCQkJICB1bnNpZ25lZCBpbnQgb2ZmLCBp
bnQgdmFsKQ0KPiAgew0KPiAgCXN0cnVjdCBhZHA1NTIwX2dwaW8gKmRldjsNCj4gIAlkZXYgPSBn
cGlvY2hpcF9nZXRfZGF0YShjaGlwKTsNCj4gDQo+ICAJaWYgKHZhbCkNCj4gLQkJYWRwNTUyMF9z
ZXRfYml0cyhkZXYtPm1hc3RlciwgQURQNTUyMF9HUElPX09VVCwgZGV2LQ0KPiA+bHV0W29mZl0p
Ow0KPiArCQlyZXR1cm4gYWRwNTUyMF9zZXRfYml0cyhkZXYtPm1hc3RlciwgQURQNTUyMF9HUElP
X09VVCwNCj4gKwkJCQkJZGV2LT5sdXRbb2ZmXSk7DQo+ICAJZWxzZQ0KPiAtCQlhZHA1NTIwX2Ns
cl9iaXRzKGRldi0+bWFzdGVyLCBBRFA1NTIwX0dQSU9fT1VULCBkZXYtDQo+ID5sdXRbb2ZmXSk7
DQo+ICsJCXJldHVybiBhZHA1NTIwX2Nscl9iaXRzKGRldi0+bWFzdGVyLCBBRFA1NTIwX0dQSU9f
T1VULA0KPiArCQkJCQlkZXYtPmx1dFtvZmZdKTsNCj4gIH0NCj4gDQo+ICBzdGF0aWMgaW50IGFk
cDU1MjBfZ3Bpb19kaXJlY3Rpb25faW5wdXQoc3RydWN0IGdwaW9fY2hpcCAqY2hpcCwgdW5zaWdu
ZWQgb2ZmKQ0KPiBAQCAtMTIwLDcgKzEyMiw3IEBAIHN0YXRpYyBpbnQgYWRwNTUyMF9ncGlvX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ICAJZ2MtPmRpcmVjdGlvbl9p
bnB1dCAgPSBhZHA1NTIwX2dwaW9fZGlyZWN0aW9uX2lucHV0Ow0KPiAgCWdjLT5kaXJlY3Rpb25f
b3V0cHV0ID0gYWRwNTUyMF9ncGlvX2RpcmVjdGlvbl9vdXRwdXQ7DQo+ICAJZ2MtPmdldCA9IGFk
cDU1MjBfZ3Bpb19nZXRfdmFsdWU7DQo+IC0JZ2MtPnNldCA9IGFkcDU1MjBfZ3Bpb19zZXRfdmFs
dWU7DQo+ICsJZ2MtPnNldF9ydiA9IGFkcDU1MjBfZ3Bpb19zZXRfdmFsdWU7DQo+ICAJZ2MtPmNh
bl9zbGVlcCA9IHRydWU7DQo+IA0KPiAgCWdjLT5iYXNlID0gcGRhdGEtPmdwaW9fc3RhcnQ7DQo+
IA0KPiAtLQ0KPiAyLjQ1LjINCg0K


