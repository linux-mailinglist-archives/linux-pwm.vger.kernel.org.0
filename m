Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B95353C3B
	for <lists+linux-pwm@lfdr.de>; Mon,  5 Apr 2021 09:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhDEHrN (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 5 Apr 2021 03:47:13 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:18449 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbhDEHrM (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 5 Apr 2021 03:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617608827; x=1649144827;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=W+uUR2fS0H6Rkmo5OmKuc59Bnp+JFrRPfgM40MXY55U=;
  b=0YNLCqWejh+kNvE8ep2MLKJJgC0JovRthe4MfOjzYJyxNipMDpBJwRhC
   nnEnyfUWW2c24gYDTpdedFWGZEoKeV9eN9rrl46f+BlUvywiA0a4Ukto9
   n+N6XzY2ETG6Z0NThu0g7Zic8e/BS4blKAW7IYnIxcC0mMEI62kGblltq
   bV1NOcH7Fv5N2PkaIDmRxvssaJ3ip0DmW1v6B5mDOuhEUfUfg2aRffqch
   +JpYCjyt4FhYLOwzOM+G6LfLFvr/j740fYLg+RpY7Q2SDHXOiP+wCSWCO
   m8NeXqYegW2mokTDHXLa7t6yqimowOrF15dcHkterjQE1fVZIxgJP8m0Y
   w==;
IronPort-SDR: T7eTK9fd69rmfzpkzHNZAQ/iClb7ZFYtxVvtm9ANBsscHqKrBCnGaBWO076mX4R0iH7XGMq504
 a5Tz7C+hvgDavkjd4RsLURO9Wa4j56A2n6iBnlnREv6L2X3LRTk8LjpCf/qisRtsf99wKbVGhD
 dZoEIIaJv8aW7oIzv0PXjbY1v2y6CsnaI1JBQed2Oy5d9UDRpIVgTl/gktL0d9QSntCzI2lXhm
 cCs6MKyRVNpik2xXd4DzNww1oldRSgtHgUiX8oH6spTrFWYhXWmGfYuRJpSDTNfo40N7l84hF/
 c80=
X-IronPort-AV: E=Sophos;i="5.81,306,1610434800"; 
   d="scan'208";a="109655075"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Apr 2021 00:47:02 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 5 Apr 2021 00:46:59 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Mon, 5 Apr 2021 00:46:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jKcC6FkARtxU6Jy2jYeqDPt5iMCZk6JZ4kQAt3xP72OkaI1bfUS/2qpWAvub41vouNhydEVOi/XVq1I3eOl1COvy2MeKnIoxEoCjpc40bS9znihR/5AoAyez7sAi21Dd3kF+7bgF8wBk0z2vca4WsPrBQ+xgCL1kBryUUFWkw/97VX1E+5LdvJ67R5AYo1/Y2MDnULaJV3vWuZzMdo/ew+IxIVXykV10R25XBOLOZUPtBv6iHbKx2VWmy7dX9Sz/iutGohw5yE3TvIgsrgELBJhLYwhIqIHUpdsw5wsQK+j9iT/41is5KhQjlEhnr3VY+d6lSNdq3nV+LfdsrTEooA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+uUR2fS0H6Rkmo5OmKuc59Bnp+JFrRPfgM40MXY55U=;
 b=CRcr8UsPaR7WLC2xudSN+VhnnIYLJ3eQTNE/eNQ0I2Vl/GiUN3C03u3ZgOnvv/lA8zEcoo/rnyRUi/JxrrKKmYn9harhS5z70TweJKEjwz0Y8KZrFljKfXbToUhLRmyfdb8Kc+zxlcMz/la9eRsyr2N86cGKFY0DOfy1DBkWePCE3r3esQ6u5/z5wAP08X1PsDjpn1zViTl3o+hFLpFiTyjAMYAlIvTXmHKR10eYW0o9CQcY2NramFcxicPow7wLA+XN2w0lMYq2mSBIEHyLdAruhEZzFtb0ZNFE4O4BRTOCpqdA43RVNxMgnOmn9mzcfTFbTVtjPUthUc2/N/QlPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W+uUR2fS0H6Rkmo5OmKuc59Bnp+JFrRPfgM40MXY55U=;
 b=OPaRiP/Jwt2/AZteqd6Vb11FjlOIzhPSQ+kpgZo/J5Gav05zPHzCC14HIGAUi0rJ3V0H+jYQGrhtNQYqJc4fBGM+6q5hF5gpLpnjaHgY0kQnKMZJO5+uVQEaD3ymGlA98bIZGFAIeMRuzFfSO+arPh6XyqHtPpQVC94t4w03/hM=
Received: from DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) by
 DM5PR1101MB2185.namprd11.prod.outlook.com (2603:10b6:4:4f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.32; Mon, 5 Apr 2021 07:46:58 +0000
Received: from DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::d405:a5f2:bb71:38d7]) by DM6PR11MB3420.namprd11.prod.outlook.com
 ([fe80::d405:a5f2:bb71:38d7%2]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 07:46:58 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <u.kleine-koenig@pengutronix.de>
CC:     <thierry.reding@gmail.com>, <lee.jones@linaro.org>,
        <linux-pwm@vger.kernel.org>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <kernel@pengutronix.de>
Subject: Re: [PATCH] pwm: atmel: Free resources only after pwmchip_remove()
Thread-Topic: [PATCH] pwm: atmel: Free resources only after pwmchip_remove()
Thread-Index: AQHXJ66otA5Ww2ByYEm53NIC/+uwhg==
Date:   Mon, 5 Apr 2021 07:46:58 +0000
Message-ID: <5c85e79e-e507-ebbb-70dc-508f7b4ecd2f@microchip.com>
References: <20210324195635.75037-1-u.kleine-koenig@pengutronix.de>
 <34080c7a-71d3-334c-498e-cb65dad9f817@microchip.com>
 <20210402202743.hvx7dz3iraesfcbs@pengutronix.de>
In-Reply-To: <20210402202743.hvx7dz3iraesfcbs@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [82.76.227.232]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 674ad984-c677-4436-42a9-08d8f806fdb9
x-ms-traffictypediagnostic: DM5PR1101MB2185:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1101MB21851D36CE149B4CD141508E87779@DM5PR1101MB2185.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:565;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CiNBcLmO6W1+wFRLYSRBCC1tmuk22SraiPDdMniYzX/w0t7v46RGCv0LM7s5yFzH1SQHBjoezeNT7ofgBTZx3blykDZRdzcvai9P/YB7BIN++BZbdfxav257Uk0vKI5H13+FOvPfRXKBOuNwipWpHypYj4yvkRAV6+aBCBxk7uyYKvjiMSthEpXH0/kgRzY6KPURI7ipBbFOnhRM+Y0xaQZ+e/7pWGn8LZm5Es9pSytz1SubW27WxFe5pwUBdWuDg/hvbvZTHy6xTouTl6A7q1AIV++9PdfiAd7D6XfcUhWTa7O7Fn1HVDhKIRopVYu8JkM3UCN+GV7bwoI2+k3lLVemm/XqlfgH2VTOdgG4udUVhPg+m6VTc+OYrkqMxbOFIUNdTTKXmnDBBB6QVAN/NfLfbeBVSQARw1KkeNzoYufRDBYNAyNLBcc17GfzsN7Wf7vuDyvTisyCokjq8/G6/shcZ/NKhooB4vzOyb3RaEn7CGVY2DC5BKR9qV+adLk6MZ6rT6+Lb3yNFHTQ7hWpWiZRQ93dbXl3LPTW8hSKx67kX7aUePF9Yoj2xp5DaiEs6u4z9dVGR4EiIrUEs/vfpDL0sjWDqY+po5aWpmQIENjcZBoRaaGCRBTIp7h3GLWkFb1inr1fi/9WdxrJA+BeyDKj6kPUdnSzgZRZx5aMfvd7FfdGngcammUDpVHPe0Tt/EdpJSs0eQEAHZjMSD/dsq03RJo5czoNfFqQOWCfKWg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(366004)(376002)(39860400002)(346002)(38100700001)(6512007)(54906003)(36756003)(31696002)(6486002)(26005)(64756008)(66476007)(478600001)(4326008)(558084003)(316002)(2906002)(8676002)(71200400001)(186003)(5660300002)(86362001)(8936002)(31686004)(2616005)(53546011)(91956017)(76116006)(6506007)(66946007)(6916009)(66556008)(66446008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?Windows-1252?Q?3a+uZ7VHSFUkdeNl9v+sjx5bBkcOWqvfxkaQ3J/UFRC1qLntJyITEPAk?=
 =?Windows-1252?Q?+Eax/5izJd+E545BzRuD/Un7QKtg0V4R3kO3czi5qd/AlOfJQNPnIjX3?=
 =?Windows-1252?Q?xR2JzpyRRjpwrpQH2Fu2rIWtBqbzhsEwx3tfp5n49A9wPIdpPCWwf6dS?=
 =?Windows-1252?Q?btzkyjT5GesueNRRqCdJ4w0IWV+Nu/efPhfDUem5GrWxe9jUgU4/iw0c?=
 =?Windows-1252?Q?mAUxkllIjmQFXRwZe3JvXPS9IGm71hpRNW4JMLU+sHjmbVDajdk1grzb?=
 =?Windows-1252?Q?TEh/gYZGKlC4utgpSERSeYuB/pPCqGatpMWtI1P2b8pQbIX+BRPUy96L?=
 =?Windows-1252?Q?mgZ4Tuxha2lcCtrc0BT22l9uyRVj9C8vXYhw3l3/9wHJjLi0/n4OJLRi?=
 =?Windows-1252?Q?vUe2/ot1bACO7KM7SkkBXosJpv+7HbXZfNO4cNX3Nem4ki6ejGNVCYVd?=
 =?Windows-1252?Q?K6KHkaTPBhJG8nUw5FUcyvAZmfI0rg1Z6azCt293jPcPqs7sHGf+M39w?=
 =?Windows-1252?Q?BcVFdUjOSEe5P7M0qR7idYhL1FDywGOWViu0X2Zw6wJzUOYowi83ccEs?=
 =?Windows-1252?Q?y6Ri2Nxbhbq9wUbG6ho1PN5hmZFfhTjMuJ7fPSw98jntzO5mqgJCu3GC?=
 =?Windows-1252?Q?P2+HLGdiwxgE9pcfZ3qBWb2gZA057O8fEEHO/HghUegXBkK8s/Rf8e3C?=
 =?Windows-1252?Q?7/7flPI4JdIEfA3lHqXciCNxMIokBWQSSRuf9f76ixpjBV2+oXap2+h+?=
 =?Windows-1252?Q?NDyoZa3lwdjR4ZqBtqZg01Es+ogmHKzsuTsQs+r9kxxHorAHi51bc07H?=
 =?Windows-1252?Q?4xlybRw+903pGPgwMthSuW53kuTNfzC9jdbH/XkoDEFjLBkONH9gfi/p?=
 =?Windows-1252?Q?+lFvwcxhFIaT0xQ84ZQDSeABvbsueIf5l7SdB7h5dQ3hFJhqH8w46xxW?=
 =?Windows-1252?Q?Hj20nAM70ghrYbkCoRboaTJg7bV6z/cBJ78vtcsXoeVMtJz5rpwE0kyb?=
 =?Windows-1252?Q?j5oX+gwT9QMBV2vtFTZcFaYT91kst+H08pAOhLhLfMAjay5SqLmCbePB?=
 =?Windows-1252?Q?A6+hkG6mPl8V4VVRUm8MOg30Zodyo55h9teB2dYgkyhpWPwzSqtzgqPd?=
 =?Windows-1252?Q?VjHl70udPoAe7g2NbGvrs6h3+N4JffkywUxHn5OV3rHFxUN7XtKK4EAk?=
 =?Windows-1252?Q?UCWcxn9a17V4vRE4KezIVe1iRDZsgQJW7YUurxgGQHbq9gA2aNrnvsH/?=
 =?Windows-1252?Q?mNponnL5puC/JJKMuq/HZRaixubXpzbAB0sPTMWWaqOpA9yBs29IZO6O?=
 =?Windows-1252?Q?wJzK72dupANaasdVelhydn0EEuvJvu9o9zUozbt91cH8op+SsAMLSqtI?=
 =?Windows-1252?Q?lkcotZHUcieycfpJZ/QRv5laO0WtxencF7I=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <917B7D775B52BA49A8F7C25485624A13@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 674ad984-c677-4436-42a9-08d8f806fdb9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2021 07:46:58.0885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FHrecu6IiwhTwAOgCjpgQRQs/f1ahDa9QMIiXOtSJNBsUKVNSJgBSVkTq0/1kyt6pWPBvy+ZTHV6+CkuKY8M59iWZBiBIpVLonIXFA52pV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2185
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

On 02.04.2021 23:27, Uwe Kleine-K=F6nig wrote:
>> Other than this:
>> Ack-by: Claudiu Beznea <claudiu.beznea@microchip.com>
> You might want to make this "Acked-by:" so that patchwork automatically
> picks this up.

Yep, typo...

Acked-by: Claudiu Beznea <claudiu.beznea@microchip.com>
