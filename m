Return-Path: <linux-pwm+bounces-5049-lists+linux-pwm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC64A4C255
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 14:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F1E43A96C5
	for <lists+linux-pwm@lfdr.de>; Mon,  3 Mar 2025 13:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2219621128F;
	Mon,  3 Mar 2025 13:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="D9YDJqTn"
X-Original-To: linux-pwm@vger.kernel.org
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169F51EEA39;
	Mon,  3 Mar 2025 13:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741009647; cv=fail; b=u7V2NOrAP5OQr2dlZTVfNEfTq7F1YlT2T+3QMLHo/8JZRO1262dPkn6kyEEevZSAjzZ+3XN/MZG7rQes7QVrd5gBsbaEaY/JpQv7lgGdgjPdp+M4GjzDlxQ0Q7I6TRwc3tA7Lhv+lQOzEkq1kkXCdMYw6e0EVIZrjw+rXTKZlBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741009647; c=relaxed/simple;
	bh=9DaLC1xSnsrLJpDSyL+KzQ7KFPPXFXKYBsJBRhuzz3U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qu4fImWw6KjDGGfMBaKv1eZNUzsA9Gvp9gVFM0dDV62cYeZwnYdtaQ0HmgeyG+x6pk8W/0ryF3ylLniCZ44Cq6qZ5HRrijQup5wj8Jv0cyjrCTwn0GA3Q6ag3IJVW20zgms0KCwqS+iDWAJMoh+815u/B8ko0/d4DlTe7UOXxn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=D9YDJqTn; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523CDcHb019529;
	Mon, 3 Mar 2025 08:46:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=9DaLC
	1xSnsrLJpDSyL+KzQ7KFPPXFXKYBsJBRhuzz3U=; b=D9YDJqTnd4yp6ulmozuyC
	6Tnj4/PmJr71h0+5HlTBl7uA9J4ULpv8Kf4/guCWVfrGrA/+BbHBpdgSyDCBnUSb
	GKDJ3dOjj3aqSVISegu8oRN7qyXJqbObpuOIdfaSDm3iRIaztegiHh+Iqmqlc8ym
	TJC2pkuHL49HsMPHKRPWSAC2QIA9yRBZeZZRPLsa54H4wfcR03jtNqRtPtv7EoTL
	faUFj8U6fJ7jz5ZG6OgPIF6TcnWuZdLygdKICb7uL30vl3raOeRbhS5EMVsOz4oL
	uIj91z4jihmNknHytUv1XBrjG0yQ7LtSvjj8V1F620Lz3bVGxZAuxDYlWcVP6+zt
	Q==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazlp17012010.outbound.protection.outlook.com [40.93.14.10])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4557fj9k3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Mar 2025 08:46:54 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhynfoX8ebSCqs0IZ2UW7WEARLZnlXuoipXUWq78OJp2uORxiXkaRDxW8ao2ieORQ/ADvbnskYoPTT/aQW5XG5GexverYaBziu0qiKGkL9E549COGFUdxmTpODMp9o4XwxvAjaKbdS5Q9OWiQq33kF/f+ajZtPmwNCGW3d5Qh5mlWyo4JzNF1klW/Y6rmxUL6rqNSzHscs6kCWOTulPgGOdSAyD3ylYUUm1fwnI47cctqbK0K0QB9pNJb23y8PQf239weRwVpC+5EX3jNR9DSrjbdAcdB5KgFrBNcn0nKJLwpkX4SznwG8Fy6hfau6UccIJtD9bKYjmxITt2cI9DTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DaLC1xSnsrLJpDSyL+KzQ7KFPPXFXKYBsJBRhuzz3U=;
 b=jDhfJ7wf2x9O1LLvi7pr3IIUcO3x5VciATkSQhh8s7ta3rYssFVPt6XOWWdHwHm4TBSrM1MwqIMn31FEZnbLgsqaM7mvoblT4AXuSXD4TU2OQAbQCzp4RAj1RxkL342DIsVCUmrvPLF5mKtJO0HZjqrkhQ6B4b+pP2oMqtBL0lDP1GTndq/LGUlii4JbFITXjHNfFfa3Qg2G8bc2sp4z/tQJzDQCMKfkNhCzzPZUyC5ewHHPsOLlI7oBnydg2E/O3z3+cqo4gfr6yut/PQNjL2Q+x6vUVBwOldR5vAR5LqmrWQpO+Oym4QNtat/F1IIQQOvcNSW1WrynE72w1GfgtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from PH0PR03MB6512.namprd03.prod.outlook.com (2603:10b6:510:be::5)
 by MN6PR03MB7744.namprd03.prod.outlook.com (2603:10b6:208:4ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 13:46:51 +0000
Received: from PH0PR03MB6512.namprd03.prod.outlook.com
 ([fe80::c8b5:7953:eec1:cb28]) by PH0PR03MB6512.namprd03.prod.outlook.com
 ([fe80::c8b5:7953:eec1:cb28%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 13:46:51 +0000
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
Subject: RE: [PATCH 06/15] gpio: adp5585: use new line value setter callbacks
Thread-Topic: [PATCH 06/15] gpio: adp5585: use new line value setter callbacks
Thread-Index: AQHbjD7N8aMeGaZsH0+LdoCoOML267NhbN+w
Date: Mon, 3 Mar 2025 13:46:51 +0000
Message-ID:
 <PH0PR03MB6512A48F698CE67687A274EA8EC92@PH0PR03MB6512.namprd03.prod.outlook.com>
References: <20250303-gpiochip-set-conversion-v1-0-1d5cceeebf8b@linaro.org>
 <20250303-gpiochip-set-conversion-v1-6-1d5cceeebf8b@linaro.org>
In-Reply-To: <20250303-gpiochip-set-conversion-v1-6-1d5cceeebf8b@linaro.org>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR03MB6512:EE_|MN6PR03MB7744:EE_
x-ms-office365-filtering-correlation-id: 7d55bbbe-e112-4d98-0959-08dd5a59da08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b3VnbFRLZlNmUVZSTGR3bk9BZlJmMjFUUW14QVNoRW56OW9LY05KQlFnSU4z?=
 =?utf-8?B?bGp5NkxqcjZrcmpXTnkxc0VYbXpOVUtJNkVIcktrZ2tFTDIvZUI2U2lFNHow?=
 =?utf-8?B?cFZJUDlWSzhhaWY4dXhWWVR2T0cxL0M1NmlmWHVtMWZMNUhXK05XWjdidisy?=
 =?utf-8?B?YjJKeWJJenlVQktGWUR2TWFCdjM0L0ZVSGI2ZjNxRHF1VUVnSmxRTGpNdjVw?=
 =?utf-8?B?NElXOXRIQTlSSURpbkZjd29seGkxbHZtWkpHcFhnYWdPRk1CQWR2ZndEMU1Q?=
 =?utf-8?B?b20vd1RHeTBrcjBUdmlwRGpDMWN3aVVkazlZRjFYSGhWRnBwVDFjZUNRVHZG?=
 =?utf-8?B?M0ZuZVhvcE9PcUtPNEFkRDRsa21QY21tQmJzZDgwNHVEaUVPL09tMVNNMDFO?=
 =?utf-8?B?Uktrd2tTSkZqZ0FlNWZHYllSQktWTnBOMHNlaENlUUR5akJiWUVKOTM5VWh4?=
 =?utf-8?B?QmU0Q0xlS3JFRmJPRGhUd1BMVmtxRkFUT2l1djYzV3JnbkF4b1k2dVNyZy9J?=
 =?utf-8?B?OFRETGtGazc0alkwVDF3djEvWXRROTFtazYvTzNKRUJwSWJpbkhqWnBNSHJa?=
 =?utf-8?B?VklOcWQxTm1rWkV6LzRMVmFBU2FUb2tha21VSjg0b291czRIcXMzamJtSmFB?=
 =?utf-8?B?bkFsNitlL3RuSHNxalRKRC8yU3ZUUDI1SHBqRkJjaHRxbzFKeUpsalNWY1F4?=
 =?utf-8?B?Ukg4clBNQWhHZlgwZjFMMmVEazZEems4cVNwMEIveXUzSXdZSGpybWJhSDZw?=
 =?utf-8?B?emwzL2tOY1JKb2dQdzlDWitHWmZDUlcrbmRJQlZmOFdxUiszVTU4T1BmSk93?=
 =?utf-8?B?WEtOcU1DV3lsSzlrcDIzSmFUd1FVYW54M055VDI3cGxWQUVCZjZ1SUI2eGpH?=
 =?utf-8?B?bUpRTGIzN0hINkRzNmdwUm1PdFdIcC9GUDQ4ZmRmeEZxazNBY2xCeVVMdUJH?=
 =?utf-8?B?R2t1ZlJUd0RhWW02ZDVyWk55eTBIRmVUdWdJTWFJSVBYd3ptdXdvM0V0L011?=
 =?utf-8?B?VmpLSXJVNktTVXdQbFdvQmFWNm1wRDJ6UFFqbVFXeUppOUVDaDNuaCtDaWlX?=
 =?utf-8?B?a3ltMHVnY0NpVDRsY2hRc1hKRzZveDI1TWw5UFFNZDVITFVoT0Vucml6c0tP?=
 =?utf-8?B?aVA3aXZNK3VXcGppZlByYXdZb0pmSnM5ZjdEbDA3UGRLeWR6ZVlCbU85V0xv?=
 =?utf-8?B?QWhRRUlFY2ZWZjZxWGp4OEZsa3JvcG82R3dNVjFGVUYwcGJHQUl5QjNwUnF6?=
 =?utf-8?B?RzlnZUE2RW1WY25HQWRnTGZqb2ZmV09UNnZDckJ0VDR2dGNxa0xJSXJZM2JE?=
 =?utf-8?B?WGZWWXBZMWdTSGhLL1VoVXNaWVdEdW1kYVJKcStwL1RXMnhPdEJJKzBvTU5D?=
 =?utf-8?B?SVRNRlhzejJ1a2VSMzcxZjhXTGR0cnhyejZSK0dVWFkyY0J2YXEvbkdZRDl6?=
 =?utf-8?B?dWN6M0hHUGdSRUNrWFRkTE85Z290dHFTSEVvTzRmZjNndC9ZamVyOG93bDJN?=
 =?utf-8?B?Mng5dVNZZDQwMyszSHhvWlpYZzFqcThhYW9ZamVqaWhJRzBYWm9xa1hiVm9B?=
 =?utf-8?B?eEFtYmJOeWhIaGw0SEhMK1F3UmZkeDFhSWdsMFZ6d3Z6dGlqRzB2QmdXeVpE?=
 =?utf-8?B?ZVpkQzhOdnN1ZFV1UkI3RjBIMFJUd3IxQjVkVnRJd0l3MStOY1RiaHFZYlo2?=
 =?utf-8?B?MUpMMDZaQStSTFRlTWhaSU5weDhuRjk0cUZRTXRzNEh4T29jemlnb244Vzkw?=
 =?utf-8?B?NEFjaG8ySE9PWXpXNk1BSkVHbCtsSVZIWjhUQ2tzd2xkOGdPMWdJT0duM0xk?=
 =?utf-8?B?dHN3SzBEbUh4YkRScEhvZmNnV0YvcXZiRHNVUkRMdkdCaGtZQWt1Z1ZtSjVH?=
 =?utf-8?B?VlRFdHUxaml4VjZlWnppYlFxNVdadkdlZ0xacFBaVURwQjF1OVp3TUZ3UHBD?=
 =?utf-8?Q?Ga32F63+UkxL8eTlInZizcmtwGVZqYoo?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6512.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?alliWWxDbitOKzF1a0g1bnAyY1BuSzdON0YwUHBZNFNVWGsvZ3d1cGZOazMr?=
 =?utf-8?B?WEFpWm9ueGFtbUt4L2NXeVlPRVg2TEhUbjI1VTN5RFZvdmtuaEFuRmRLUUh3?=
 =?utf-8?B?NnRoVFExZldrVm5XNm1WbEtJVHBnaW95M3RLSitiYURUbXRabTA0ZzNPYnZy?=
 =?utf-8?B?QytHR0tZblF1V2d6UkE1NkhpTi9qZ0pVUDNJY2wwVE02ckZ5elZqV25ybkNM?=
 =?utf-8?B?bXFtQTFVR2xOeUhsVGU1cXRmWC94UDZHN2pHbW1zSmRJRUp6TmNTWlMyUzNB?=
 =?utf-8?B?Z3pSeTkwVVI2YjYwVVNua0NXRkFYTjRteWlTQldjREI2Z2lXUFJBNHRuVEl3?=
 =?utf-8?B?eWN0SHdjZ1hvbklpdTNDK1gvREdBR3hWRFpDeDNqSWZVNmtpRERoTkl3Z0Ja?=
 =?utf-8?B?YzlVZ0R1WW9zSThmNzdqZlJYcHF5VGdqUUFtWjd4UDZDdlhueTZVVGxTdjU2?=
 =?utf-8?B?dFh5cGMvOGFBUUZQYWt6MmFtaEs3TFYrRXBUTjNtcFl6Tm5zZmd1OUNxUUJM?=
 =?utf-8?B?Mk1Lb0xqN0FZQXcweTBHUWlpanVMZUltRm9GSjlNYTZKS0s4L0pnMVh5UGhy?=
 =?utf-8?B?OUtjc29WU3lqR3RPYWJsVHZoRkdPQ3dhZ2NSSVVJOFhzQmdqWmlEYmdHVzA2?=
 =?utf-8?B?dzRGNktZSWxOcGpLQ1MwYzYwaEFyZnhEcm5RTlZjaXRNV0Q3alpFbHZmZlp6?=
 =?utf-8?B?ZVU2WkNNVWFWeFBxWE1SVXVqYzRJWlJaK1J2VEJIeEZEa05aU3d6ZnFFb1VW?=
 =?utf-8?B?QWNkM1BmZU5PeFVHWDl5SzhpUHlOUkg3aEpjK1R1TnR3ZmJFRGdzWU42bzlk?=
 =?utf-8?B?b2lOWlBqMzlJSnhkZkxMYTdkRURMN1RRZWYwWDhsQUN3V04wSDZOL0tRUGZW?=
 =?utf-8?B?Yk9ZT0NSTVkwbFluVEV3SytHbXl4R1NkSGNhM2U1dWtETm9FRTdUUC9FN3hJ?=
 =?utf-8?B?bWkvNnZtcm14Q3hPVlkzL09xNzAxdnhRRGlBSmk2TWdVMEt2eTUvWmJqZWR2?=
 =?utf-8?B?TE5qNXp0Y3VjelhqMjBObEZJMEgyQUJJUUlJRzRoU1pZMjZrUVhKRFlyU3Q4?=
 =?utf-8?B?Qk45WlV4MnRXZXYwblhyQmtRWm5NdUlEOEVmbVNGRnYzRDJ3S1U3bm5PN2tF?=
 =?utf-8?B?VHBXMHhPb2h1TUIwQ0RYelFaWHFQd2F4N2ovUFB2SEFOcTVLWVdZbEEvdHhN?=
 =?utf-8?B?d0hsT3NncjFmNmtjK3AxQVlad0p1aXdlYkU4UXdvbmJKQ1VPNU81QXkwRExa?=
 =?utf-8?B?R3BqQmtoSmdydTRxTWFId0k2SjJ0eVF2T1BSSVA5eENxTy9KeVMxeE9iZU0x?=
 =?utf-8?B?UDlBVzZpZ2tCVWRCYUM1cG9saTR6Y1dsVDdmK3g5TlZ1SjB1aHRNbzcrMjNt?=
 =?utf-8?B?Z3U4dEwzbmdib0F0T0V2UHRsZ203REh1KzBTMkZNUWYxeDd6b0FacHpvSXZM?=
 =?utf-8?B?RnpQTkhsZkVVb2pkUTN3eXIvQytyTFc0eXBSUE9GRndHY3JVWFI1aW5HcnNt?=
 =?utf-8?B?RnpPU0RzSnltcGZxNWhJcit1ckZzeXl2Zkl5c0lLTUZmV0JCWWJwNmFLWjdS?=
 =?utf-8?B?N1JjUUszeTl1Zk1FVkh0S3BiZWhKc1Nod0JpUGhlVUNzb2t6ZGJydVArSGxJ?=
 =?utf-8?B?UmkzMk9EWkljV1VhNW1vc0hXWTlWaXpWam4vaDFydXNUbGFEcWZPYTBZWkdI?=
 =?utf-8?B?WjdveGMxT3lMLzZzRlc2ZFZpdjFjeTdGb0txQUk0ajBlbUFsZ1pOTjBXaWlv?=
 =?utf-8?B?K0pPdWxLVXJiQ0RWOWRTVEpLd0pRUzM5eEdYQlZ1SGw3SlRhZWdsSjEwUGFj?=
 =?utf-8?B?Z1dsSVl5YVZNWHpMMnJjMS9DOWU5dzdNOTZBUjRoODVDeStkcUhiOXdqZ1Bz?=
 =?utf-8?B?cm81bGphUHZkd2cvYk9TWDluN3Z1WkZjaXpNRUZvSFpCeUZKOVd2L29SV005?=
 =?utf-8?B?dVBvSW43Rkt6YTN5bkx6WTJHbnhZUjdwcGVhU2VNKzlEem03Q3JpUmplV0Vj?=
 =?utf-8?B?dklkcHVrdXlCN1V4aUE4VWNES0VHaW44TW9maTY3N0NiWGZjQ3hWNElkWUM1?=
 =?utf-8?B?Q1ZZQStVQlEvR0MrSTZMcTh4Y0QrT3FtdlhpQ0dGRDZ0WTlTK1M5SEw1clhx?=
 =?utf-8?B?QVRyc0pOTEFzTFpaaHkwM2M0SW1zYXpxTTVJTUdEbTJlNFdHVmNsOXBMWjR4?=
 =?utf-8?B?dUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pwm@vger.kernel.org
List-Id: <linux-pwm.vger.kernel.org>
List-Subscribe: <mailto:linux-pwm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pwm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6512.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d55bbbe-e112-4d98-0959-08dd5a59da08
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2025 13:46:51.2696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ggGnHVGCKuUmoHitgoBfh1dC3iPReHfd+iQvnOkAlQxodAnVPi+zg2s4L9rXAxOgCbZutru2QCXPxR+t8XeO7nQ2rsGnNxVTG7lAI0dHjoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7744
X-Proofpoint-ORIG-GUID: KYo1vnv8L_xnWTUoTepW4eX8rKZBuV6M
X-Proofpoint-GUID: KYo1vnv8L_xnWTUoTepW4eX8rKZBuV6M
X-Authority-Analysis: v=2.4 cv=U+doDfru c=1 sm=1 tr=0 ts=67c5b2ce cx=c_pps a=5L1ZokDb34JZJib1CqSWiA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=KKAkSRfTAAAA:8 a=gAnH3GRIAAAA:8 a=P1BnusSwAAAA:8 a=QyXUC8HyAAAA:8 a=7KBfExy5AAAA:8 a=VwQbUJbxAAAA:8 a=w1d2syhTAAAA:8 a=JfrnYn6hAAAA:8 a=voM4FWlXAAAA:8 a=YVjOitX3pUA4POl4yWIA:9 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
 a=oVHKYsEdi7-vN-J5QA_j:22 a=D0XLA9XvdZm18NrgonBM:22 a=eL7OMsOqQ-6kYQPn45L1:22 a=YXXWInSmI4Sqt1AkVdoW:22 a=1CNFftbPRP8L7MoqJWF3:22 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 clxscore=1011 priorityscore=1501 adultscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 impostorscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503030105

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
by5vcmc+DQo+IFN1YmplY3Q6IFtQQVRDSCAwNi8xNV0gZ3BpbzogYWRwNTU4NTogdXNlIG5ldyBs
aW5lIHZhbHVlIHNldHRlciBjYWxsYmFja3MNCj4gDQo+IEZyb206IEJhcnRvc3ogR29sYXN6ZXdz
a2kgPGJhcnRvc3ouZ29sYXN6ZXdza2lAbGluYXJvLm9yZz4NCj4gDQo+IHN0cnVjdCBncGlvX2No
aXAgbm93IGhhcyBjYWxsYmFja3MgZm9yIHNldHRpbmcgbGluZSB2YWx1ZXMgdGhhdCByZXR1cm4g
YW4NCj4gaW50ZWdlciwgYWxsb3dpbmcgdG8gaW5kaWNhdGUgZmFpbHVyZXMuIENvbnZlcnQgdGhl
IGRyaXZlciB0byB1c2luZyB0aGVtLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQmFydG9zeiBHb2xh
c3pld3NraSA8YmFydG9zei5nb2xhc3pld3NraUBsaW5hcm8ub3JnPg0KDQpBY2tlZC1ieTogTWlj
aGFlbCBIZW5uZXJpY2ggPG1pY2hhZWwuaGVubmVyaWNoQGFuYWxvZy5jb20+DQoNCj4gLS0tDQo+
ICBkcml2ZXJzL2dwaW8vZ3Bpby1hZHA1NTg1LmMgfCAxMCArKysrKystLS0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3Bpby9ncGlvLWFkcDU1ODUuYyBiL2RyaXZlcnMvZ3Bpby9ncGlvLWFkcDU1
ODUuYyBpbmRleA0KPiAwMDBkMzFmMDk2NzEuLmQ1YzBmMWIyNjdjOCAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9ncGlvL2dwaW8tYWRwNTU4NS5jDQo+ICsrKyBiL2RyaXZlcnMvZ3Bpby9ncGlvLWFk
cDU1ODUuYw0KPiBAQCAtODYsMTQgKzg2LDE2IEBAIHN0YXRpYyBpbnQgYWRwNTU4NV9ncGlvX2dl
dF92YWx1ZShzdHJ1Y3QgZ3Bpb19jaGlwDQo+ICpjaGlwLCB1bnNpZ25lZCBpbnQgb2ZmKQ0KPiAg
CXJldHVybiAhISh2YWwgJiBiaXQpOw0KPiAgfQ0KPiANCj4gLXN0YXRpYyB2b2lkIGFkcDU1ODVf
Z3Bpb19zZXRfdmFsdWUoc3RydWN0IGdwaW9fY2hpcCAqY2hpcCwgdW5zaWduZWQgaW50IG9mZiwN
Cj4gaW50IHZhbCkNCj4gK3N0YXRpYyBpbnQgYWRwNTU4NV9ncGlvX3NldF92YWx1ZShzdHJ1Y3Qg
Z3Bpb19jaGlwICpjaGlwLCB1bnNpZ25lZCBpbnQgb2ZmLA0KPiArCQkJCSAgaW50IHZhbCkNCj4g
IHsNCj4gIAlzdHJ1Y3QgYWRwNTU4NV9ncGlvX2RldiAqYWRwNTU4NV9ncGlvID0gZ3Bpb2NoaXBf
Z2V0X2RhdGEoY2hpcCk7DQo+ICAJdW5zaWduZWQgaW50IGJhbmsgPSBBRFA1NTg1X0JBTksob2Zm
KTsNCj4gIAl1bnNpZ25lZCBpbnQgYml0ID0gQURQNTU4NV9CSVQob2ZmKTsNCj4gDQo+IC0JcmVn
bWFwX3VwZGF0ZV9iaXRzKGFkcDU1ODVfZ3Bpby0+cmVnbWFwLA0KPiBBRFA1NTg1X0dQT19EQVRB
X09VVF9BICsgYmFuaywNCj4gLQkJCSAgIGJpdCwgdmFsID8gYml0IDogMCk7DQo+ICsJcmV0dXJu
IHJlZ21hcF91cGRhdGVfYml0cyhhZHA1NTg1X2dwaW8tPnJlZ21hcCwNCj4gKwkJCQkgIEFEUDU1
ODVfR1BPX0RBVEFfT1VUX0EgKyBiYW5rLA0KPiArCQkJCSAgYml0LCB2YWwgPyBiaXQgOiAwKTsN
Cj4gIH0NCj4gDQo+ICBzdGF0aWMgaW50IGFkcDU1ODVfZ3Bpb19zZXRfYmlhcyhzdHJ1Y3QgYWRw
NTU4NV9ncGlvX2RldiAqYWRwNTU4NV9ncGlvLA0KPiBAQCAtMTkyLDcgKzE5NCw3IEBAIHN0YXRp
YyBpbnQgYWRwNTU4NV9ncGlvX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYp
DQo+ICAJZ2MtPmRpcmVjdGlvbl9pbnB1dCA9IGFkcDU1ODVfZ3Bpb19kaXJlY3Rpb25faW5wdXQ7
DQo+ICAJZ2MtPmRpcmVjdGlvbl9vdXRwdXQgPSBhZHA1NTg1X2dwaW9fZGlyZWN0aW9uX291dHB1
dDsNCj4gIAlnYy0+Z2V0ID0gYWRwNTU4NV9ncGlvX2dldF92YWx1ZTsNCj4gLQlnYy0+c2V0ID0g
YWRwNTU4NV9ncGlvX3NldF92YWx1ZTsNCj4gKwlnYy0+c2V0X3J2ID0gYWRwNTU4NV9ncGlvX3Nl
dF92YWx1ZTsNCj4gIAlnYy0+c2V0X2NvbmZpZyA9IGFkcDU1ODVfZ3Bpb19zZXRfY29uZmlnOw0K
PiAgCWdjLT5jYW5fc2xlZXAgPSB0cnVlOw0KPiANCj4gDQo+IC0tDQo+IDIuNDUuMg0KDQo=

