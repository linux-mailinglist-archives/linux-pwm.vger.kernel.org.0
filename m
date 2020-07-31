Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9252346D7
	for <lists+linux-pwm@lfdr.de>; Fri, 31 Jul 2020 15:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbgGaN01 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 31 Jul 2020 09:26:27 -0400
Received: from mail-am6eur05on2068.outbound.protection.outlook.com ([40.107.22.68]:7520
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728252AbgGaN00 (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 31 Jul 2020 09:26:26 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fvl3IfAIhTuNZskvahn7ezKRobI3hYNIEatSasMOikx/xPGs/fkVgjiUK0pVUEzhdTw/cxgLp0s6LJ/CAc8wtMf5jHu6igUptN64k2coRqxPwa/I813If5oTEjGUucA5OOMuRHjUNT5w2Pye57yjUeJxWHoSdeYHKmdsrk6bnoqGDnUAaAn1PrlH8fov9uMQZTExAznr83lE3/8KH4bwBY/CMpv5E1yan/vtnDZ8rRwPndksdXPPunsPZJkj5hueJKQ8we3aUiBRxCwIEPX060EyZKubUBWo4DBCxPKsFh+ZHgX5HlUAWRZ9u1OGTB0ALgLqvUI1bXcfIo3D8HwzHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27CDr72NqOLE3fWrVG23iLfVAXz3w/9hVHD3Na3G6rY=;
 b=kNEZmz8BV8+fWYLA4egi90AEJDHkGum5nA6jiFzZVolQ39Tk5lFZo26wKhuPZf7h6MWbLAirQv51YjTDhfDRyI4Cy/PxMykaPLAj/F/2ep6wUQSgO4pQZwwvRbPcbF7pb9heGz6seSdlcqu2qtpNIOUktGEUoty0K7xSv4xUf/BEyNLc/GuefRyG2rPbqHsMM7nGRrXPytJkbk9dJ2v7dHLKC1UVsdPYXiVmU61JSdAypG0TIQu+0iHxYwgyQ3t6j1ZUe8aUrsAtZTBb872s4z4EFBy00JhGte8CG+4gpBZWVvPD+i81HN+zbUUSizRIBKBSITUiQTWzX24ckXvJaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=27CDr72NqOLE3fWrVG23iLfVAXz3w/9hVHD3Na3G6rY=;
 b=tUZQrB59tdfl7c+f+INCfEJv6ofv/8fIi1YyPydbMazwnRu+TRQ+NeZ32YSDmGwfEWt/jysloTPp/cFRqyJ9zoLDdVlB2SsR+VFmPo+o9N6RQ/EBbTNbEe0r9hpSeYz0+U4pITBf1g5t7RLkA1Uy5GEkxSQT3qukFyqwQLwyqNI=
Received: from DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:e9::10)
 by DBAPR10MB4185.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Fri, 31 Jul
 2020 13:26:23 +0000
Received: from DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9913:d1be:cd0f:a620]) by DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9913:d1be:cd0f:a620%6]) with mapi id 15.20.3239.020; Fri, 31 Jul 2020
 13:26:22 +0000
From:   Roy Im <roy.im.opensource@diasemi.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Roy Im <roy.im.opensource@diasemi.com>
CC:     Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Brian Masney <masneyb@onstation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, Luca Weiss <luca@z3ntu.xyz>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        Rob Herring <robh@kernel.org>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>
Subject: RE: [PATCH v18 3/3] Input: new da7280 haptic driver
Thread-Topic: [PATCH v18 3/3] Input: new da7280 haptic driver
Thread-Index: AQHWZVgP/N9464pJ20GmrAtQIjgduqkeGogAgAB+nQCAAPuTgIACGZZA
Date:   Fri, 31 Jul 2020 13:26:22 +0000
Message-ID: <DB8PR10MB3436DCEFD5A4FDF66B9839EE854E0@DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1595991580.git.Roy.Im@diasemi.com>
 <23b3470401ec5cf525add8e1227cb67586b9f294.1595991580.git.Roy.Im@diasemi.com>
 <20200729063638.GY1665100@dtor-ws>
 <DB8PR10MB3436EF37E1F1581BDB7996C785700@DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM>
 <20200730051013.GB1665100@dtor-ws>
In-Reply-To: <20200730051013.GB1665100@dtor-ws>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [1.234.57.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4af37b7f-ced9-42b1-113e-08d835555186
x-ms-traffictypediagnostic: DBAPR10MB4185:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DBAPR10MB41859E2FD48B6CDAFF8E7A97A24E0@DBAPR10MB4185.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uyjEt1guyDH8ygl9oHOtHp1c6a7wGhXQQBFgnWrHmCECFW3LOVy+/084VOac1ZM2X5zSe+pnBPtSHzaPJUERvbeSGo5AS6tH/ptURBuEMvSIynGeIjiDjYRyNcmZncvmz9Wh4dNT2KxlrEBmSDHUN0cwGMsIQ9HO0oeueb9RqxJxhqD4k9cso8DHHbDsZtam8zfBA6U6uApcKIBjzPbNiXHoPNsJv9hIfDx1TsV9SpHG52nzKZBs0d/zeHPj5K14pwL5j31CkcjysiB2qNCXCNoObX28jPnrjeVeQfhDvKT8sQX7iF4b37/8fSHppJijBscCipaL6Knp6H92OdTktQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(55016002)(8936002)(7416002)(316002)(110136005)(186003)(54906003)(52536014)(6506007)(26005)(86362001)(9686003)(71200400001)(2906002)(8676002)(7696005)(5660300002)(33656002)(83380400001)(76116006)(66946007)(66446008)(64756008)(66556008)(66476007)(4326008)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: NcTOEZUbPpIMd3wtRVsifphlUaYxJqbntSWj2TtzZ37paxYzZqD5cW+LNT5QqPaKGDvKI4/NzsXxs+R88UAdKIa4PuJi6WTUY1O7m6BOMPGu9/F5BEtQYktz9cl8KfGjT3xJjiJK8PYlwgZdddj0olJUnsLrcVklYFf7uitwoj8UKOW0uZSBjbA35GigSYdZoSCVvZvSYWJGzVsF5GzMCst7OHA7eT4oc6UfdcVnnwsZrB3w8SEFMGQRx1nfu8PPnsEfQ0yIeR/63iFT6HmjG6h9Brl8z3jzCPMrGSN2tJbUDauruprkiE4P0s7w/Q6f7x81yVeHWutLLnag+bzSFRpTjUQAlHWajeF2jNBFwiiV+wR6WlA4SiL3Z56Rl8AYn+p5BvSf2FFLpe78z/H+f9CXzCZx1Fgwkvdw7TZYgdKhr/mBsI6ao3T4TZIOTIwkm5C0a1euBx8ogmAnUzmQhg/10dBihL5NDv+RR/yAJEBq8qhxNE3gBYXJQEKiH0rOHS66+OaME9z7x2KckPnYDNKk9Ikhk7qHTcrBPwtpllc0X3Jl9wXeO36n5COc81J1nC5EvIQ044izrCz0uJ0BE4IFR2glakpY5yFJuNYxdOlNs16c/hBwbxNG/Mur1yXypXpMO0oGyvfs5NbnzWrNOQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3436.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4af37b7f-ced9-42b1-113e-08d835555186
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2020 13:26:22.8038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b61pf1YwTISkytQ++w3NXXFJ0VUU+NBtMiP178Bh3XNniFnIsxpTYzq4k1CbxWkT7jrKS8OmeUgKJY44tCG8kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4185
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org


On Thu, July 30, 2020 2:10 PM, Dmitry Torokhov
> On Wed, Jul 29, 2020 at 02:09:48PM +0000, Roy Im wrote:
> > Wednesday, July 29, 2020 3:37 PM, Dmitry Torokhov wrote:
> > > On Wed, Jul 29, 2020 at 11:59:40AM +0900, Roy Im wrote:
> > > > v11:
> > > > 	- Updated the pwm related code, comments and typo.
> > > > v10:
> > > > 	- Updated the pwm related function and added some comments.
> > > > v9:
> > > > 	- Removed the header file and put the definitions into the c file.
> > > > 	- Updated the pwm code and error logs with %pE
> > >
> > > I believe the %pE is to format an escaped buffer, you probably want
> > > to %pe (lowercase) to print errors. I am also not quite sure if we wa=
nt to use it in cases when we have non-pointer error, or
> we should stick with %d as most of the kernel does.
> >
> > Right, it should be %pe as you and Uwe said, Uwe suggested %pe to under=
stand easier.. do you still prefer to stick with %d?
>=20
> Depends on the situation. If you already have ERR_PTR-encoded error there=
 is no reason for not using %pe, but if you have
> integer error, or you have already converted pointer to integer I'd prefe=
r we stick with %d.
>=20
> As I mentioned in another message maybe we should consider adding '%de'
> or similar for formatting integer errors.

I have seen the discussion messages in another email, then I am not still q=
uite sure what could be good for now.
Do you still prefer to be with %d if I have already converted pointer to in=
teger and with %pe for something that I already have ERR_PTR-encoded error?

Kind regards,
Roy
