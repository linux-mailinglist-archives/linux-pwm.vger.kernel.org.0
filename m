Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDAD82C8064
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Nov 2020 09:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgK3I4g (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Nov 2020 03:56:36 -0500
Received: from mail-eopbgr60087.outbound.protection.outlook.com ([40.107.6.87]:32238
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726270AbgK3I4f (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 30 Nov 2020 03:56:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYxhG/7/yMYodbBSTcXGGeeGI0QsvHZUhLe367Qqy6KdLmLIEAhsaBf0gbDUM2dJxGFVygBmSXV31L2TICR6c7V7140x1en/idkh7gh3x6J65XwDLVW6OniC/+IKngyz246wvxsQaBIVBOKGYWIrtvxVQItIqjvTdXTRafnF6Xujpf/PcZGAPFPpri5kia17p+n1RwFRXCwrUoGnXTo1ZDJSM325Sq8JSSz/2U0rDIq8zBjnz0XsYBnivTmrJ53DwgP+7h5H7w2NkQ0RrSsLADr/oQT24kifBUgcejBquNZE2U0qUrtMg8ZSUbnWVBXQAI3zT/EHaRzpqpJcIcESXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0RBG+4k6FE81+OjJ6D4Al0hSe6i8/omYYVsuKs940Y=;
 b=dVrkO7aPCB60T4XbvGzz8vuwcM2c+9jmcsyAfLCUCsPJLZQNLpDF8PDBKqz1AtZnKkPyNFVAjcABtqRz9yCnTV4PK9sH0wfRn5EKyTM0CQbrOOIowt/Xf+jm2P/mPVH3iU7XB7rJ6Q7KjRJCt6MSSHMZvoarxAqBhfWUKSTpTY/c7pfGszqI+CyE4vK9+FiF7F9cYcoCuxG4KEnMJUAMzrBhSrjqFF9gUMgJWO4p+JKajr+nNWVJn6b3Q4xJTaNORHz3gUyo9JG+yeV6y7ieA75GK3/oj40dtjt9TETwRSXgSBGqZEOwBGTgbvk2hPOtMDe2EnGpAv8komLBZF0CNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0RBG+4k6FE81+OjJ6D4Al0hSe6i8/omYYVsuKs940Y=;
 b=RtkIi3sspynhljHwPl60j60CvoWd5CXgvDZ0DfG4N72fb37yJfRbImsIcTA+A7TsOukXMzmiWDIpCGpmFuNcfi+nAhLYJeAcLSQTzKxXn4WpoQRrGufOMa1HdRSyl7osfcqYlvnljwXk9yqj2NULb6rTDU9vKqz6rpie0RqhXBQ=
Received: from AM6PR10MB1926.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:35::12)
 by AS8PR10MB4358.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:2e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Mon, 30 Nov
 2020 08:55:45 +0000
Received: from AM6PR10MB1926.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8805:7516:b929:e052]) by AM6PR10MB1926.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8805:7516:b929:e052%7]) with mapi id 15.20.3611.023; Mon, 30 Nov 2020
 08:55:45 +0000
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
Subject: RE: [RESEND PATCH V20 3/3] Input: new da7280 haptic driver
Thread-Topic: [RESEND PATCH V20 3/3] Input: new da7280 haptic driver
Thread-Index: AQHWw0ifTnYOEn/U4UK9rT8zNgJ3kqngVcQAgAAPyzA=
Date:   Mon, 30 Nov 2020 08:55:45 +0000
Message-ID: <AM6PR10MB1926144D8B1A4630316E89F485F50@AM6PR10MB1926.EURPRD10.PROD.OUTLOOK.COM>
References: <cover.1606320459.git.Roy.Im@diasemi.com>
 <1e293e8c4830b09255af3b7e1721b73afaefdfa3.1606320459.git.Roy.Im@diasemi.com>
 <20201130075528.GM2034289@dtor-ws>
In-Reply-To: <20201130075528.GM2034289@dtor-ws>
Accept-Language: ko-KR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [1.234.57.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a3ad369-6eff-4178-20ae-08d8950db99c
x-ms-traffictypediagnostic: AS8PR10MB4358:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR10MB43586A29356F29467A147AD8A2F50@AS8PR10MB4358.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kiJQVgSRX3CpjdGshNz9/IYeZk4Yh9EJ3ym+uspHuI/AUrWISJ7PSEFHTaTLSe+bV3pzidb+pCcb0IY76/qzpBVGXdYY09kY//ItNwU+l4TlC0pC77jHDUcgXhkItwqFDNpHUr7jIUKRIlo5XSTOJw6tf5RnTARQuHmJaSzlFt529zCXydIzutmQm3MPFMC7oD0epyb8xd6gTNADA9Lzvp+y7TOxOwrX9zwlO8GwcsZOMUhqZT8XVZII/QcmORCezgiJeE1UpeCbsXNs4Dpj2GquKTTUVq4yHBBKC4KJv+GpTT49xt6jIKyZXXznWxOp4/fWgokvLS+N0MUWQ6+Ghw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR10MB1926.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(39850400004)(376002)(366004)(396003)(346002)(136003)(64756008)(86362001)(478600001)(9686003)(33656002)(71200400001)(4326008)(5660300002)(7416002)(55016002)(26005)(2906002)(8676002)(54906003)(7696005)(110136005)(52536014)(316002)(66556008)(53546011)(66476007)(66446008)(4744005)(66946007)(6506007)(186003)(76116006)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?jG18qwEs5rs3oICxgLPGcOhKgggclqj2gSr8uVPYme0hVfIEkev+k7SkYrBZ?=
 =?us-ascii?Q?NJahnT20S3z/+04ppDdNt0n+SolHKURlMNYricsnyNEKGERitCjRwaK8g1GO?=
 =?us-ascii?Q?kl9ottFxImRfqRc9xBfwTIxxC+Fen6vLeF4dQLL1FU2+8nIsxnx5YAR8pkZF?=
 =?us-ascii?Q?qXI8uGTT8qZKSgif6A7MrG/1UOe7VYAbfiY90RoE1iO4mf9eD4A8Dz1VDhQC?=
 =?us-ascii?Q?/VSd2lh2gHIF5pkKB2NN263zxD4vlSuEKoI7pWoPzjYx5SRABoK2Cq85g3wh?=
 =?us-ascii?Q?g4rNEuF01xJCZQb13YwESMzdBvsRKQp9YeBSgYPLLcmvy1HV62EoEHn7PCQh?=
 =?us-ascii?Q?8d8oWXxkGDv9aa1eCbz/2E9estmaZrKNnYQlqPbaYpEXGVmq0ajy7ZNEwS63?=
 =?us-ascii?Q?/c9XSxvDgDmKIZaO+K644nKUNhO7FkSsteOBM3NVym2MtivDVQU2mj2MmpKI?=
 =?us-ascii?Q?zRQYdHH1SqjYrUrYEXwGbAWEgA0tyIixfGZs7M9a8m/Q5Lgb5FLr0Ts2Y0e3?=
 =?us-ascii?Q?Cz1FP17HQzLD5w0w/jtJnZ94xUMLTKn+LRh/nl5uN1IhNisgVwpa3uaNB0To?=
 =?us-ascii?Q?GIFqQcA6aGQczp7NPkrgPrx49NoYH0MZbMRIZI6ZJQ54m/IlZtPAOFpKlkA/?=
 =?us-ascii?Q?0t3KGWz7IsPX605l4Pj2eoe00DlI3Y4WkvnsFeHS0etSno4k8DncNjPgKJIq?=
 =?us-ascii?Q?CL6l7mn/F+tKBUkJfi3jfoSKjsZr/Je3ibwj1xTw62BjtstlNOLXqLv6sGqg?=
 =?us-ascii?Q?hv4iBJ07R/+rXVc41pydTibaXSS84hUrb4HdlIiKP25RbS7PCSG0HPubuTt6?=
 =?us-ascii?Q?LqT4yq88lGcHHAeulfJR6QTXhOe5SINXf/p8cyk928ExLkJh6VCEXrb0cJZw?=
 =?us-ascii?Q?CoM1TkeOYnrKk7insucAVvWaMveNo5r76VLJicSU96Z+tvblyoU6vJ1JRv+S?=
 =?us-ascii?Q?V9bp5Ig8dFt6+i4jbLfIuN4gD1y/uJYh86rXmN/KxQQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR10MB1926.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a3ad369-6eff-4178-20ae-08d8950db99c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2020 08:55:45.2806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sY6KkGBqzmyMud8L81aMchKcyPV9eqEgnhE1NvXxIlXh6+DBSJbpc+kg96Z+q/Ey2E+FFkVDryFDnWINfPdPxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB4358
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

> On Mon, Nov 30, 2020 4:55 PM, Dmitry Torokhov wrote:
> On Thu, Nov 26, 2020 at 01:07:39AM +0900, Roy Im wrote:
> > Adds support for the Dialog DA7280 LRA/ERM Haptic Driver with multiple
> > mode and integrated waveform memory and wideband support.
> > It communicates via an I2C bus to the device.
>=20
> I am looking at the driver and should finish review tomorrow. If you do n=
ot hear from me by Wednesday please poke me
> again - I want to get the driver into the upcoming merge window.

Thank you! I got it.

Kind regards,
Roy

