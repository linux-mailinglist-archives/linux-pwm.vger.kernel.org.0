Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4425ED486
	for <lists+linux-pwm@lfdr.de>; Wed, 28 Sep 2022 08:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiI1GPE (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Wed, 28 Sep 2022 02:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiI1GPD (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Wed, 28 Sep 2022 02:15:03 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2131.outbound.protection.outlook.com [40.107.114.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5CC86737;
        Tue, 27 Sep 2022 23:15:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fg4gQHVFrk4nFxq/0LEjzsoeWRY2CFazJTG8p0Jxd7dAxgpMWINuhTb5pfOs7sAQWdeSPs6GxoLWeVbO9abhKJEhIAL8UmJ+T+r1v/x6Rv03eZx6mGsQKv7KJrKA2BlQEvTibq1GPzpR5gqMSdUzAqgMqsYU8r3DvzE5Db+KbXZLrnYUTzHR/e5MTAGFGOdg92D6SyPz4nWEjVz4TQB/x47GCehs+1SliXXm3Gc0kiL33y52MMuIj7rjevKM+CSl0sEXiczTa+it7YK3U0BDnqtz1x9bvkDKMzh3MXYSyATnRfc5INGO3wvmX7dsRPohYbBXDQT1YoHiBapAj1iBEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZijCbLhm0M0ZWa2vkKMXKckA4XxcwF6BlEKjiTvjpY=;
 b=HVKdq529vMNjP4ym7npGySvXDaMG/zeoMBNDbrjMnXUOeHUim2mArvWpZ9FqoikX+WH2yVhhxuZvsqPQ7e2IzuUc7siYkTLTxXTgZOBiiMaWYafj81E5inLhYbYYTwapsOIfQwbbk5dTGcrmqla8yHHJ1EXJOZnxEOYfRRNQ1dc9owpzWpKeO1eUcjsz2RQWnqvrmoxxPLEyuOQhKm/JSG46Mj9+LAQYr+f4ZZqMemncaYZRTMslKKadteaBiVh+9RUzoA+z4bQkCLw70qVGg05OK4oUfYCjfu25BK96V52uMV61iOw5KtRb7bp2qnDax63b6B6HaMlN8Qg8RUbiLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZijCbLhm0M0ZWa2vkKMXKckA4XxcwF6BlEKjiTvjpY=;
 b=rCjgiKRh8gWliLtOjGLq+sQddZnmslNyAPlLxvKC0I0m5G1CxkoxV2c46cLqhrMNTv0OI+hAymbME1vlcKK0NqDBatFC41xFv4uc8e3l0LiCUosBsmIwpUHXJ9HhpJENoLwHK+vgVoosMo649nBs7qh8EwAr6DM8dmDZieP9QxE=
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com (2603:1096:604:bb::5)
 by TYCPR01MB10102.jpnprd01.prod.outlook.com (2603:1096:400:1ee::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17; Wed, 28 Sep
 2022 06:14:59 +0000
Received: from OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262]) by OS0PR01MB5922.jpnprd01.prod.outlook.com
 ([fe80::73a6:588d:1198:7262%7]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 06:14:57 +0000
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     William Breathitt Gray <william.gray@linaro.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lee Jones <lee@kernel.org>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        Biju Das <biju.das@bp.renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH RFC 0/8] Add RZ/G2L MTU3a MFD and Counter driver
Thread-Topic: [PATCH RFC 0/8] Add RZ/G2L MTU3a MFD and Counter driver
Thread-Index: AQHY0arfC6iQwXKfcEeqoNkH1bZYIq3z1zkAgACGWoA=
Date:   Wed, 28 Sep 2022 06:14:57 +0000
Message-ID: <OS0PR01MB59228FA93ED4D6DB8D9B799D86549@OS0PR01MB5922.jpnprd01.prod.outlook.com>
References: <20220926132114.60396-1-biju.das.jz@bp.renesas.com>
 <YzNztKSYQPQrnV7k@fedora>
In-Reply-To: <YzNztKSYQPQrnV7k@fedora>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB5922:EE_|TYCPR01MB10102:EE_
x-ms-office365-filtering-correlation-id: b8b51e90-a4e9-4f6e-cc1e-08daa118c47a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dzIBr6Qqnc35/skV8zr2gs1WY/cXqmi9I/6F+dqVDMQLoS+Ue4rxCjAadSSrwvtEqYhaleDRtVxkvcsN54rNwJSBU8h0VtyOMxHMGIwVPQA4T+Q+gfujRhy2TdkVw8LUyk2znxkBy6eLMUU0c/TxSIdfz4L/4YgmuwTPujJeo44z7GhYk+kXihnHcDrQmOqlSgbNp5iVi3IrzP18zqAt1BoQN86AlrajiYGQ8zqRUDg5XnYzRz/fLMQknFMK51/Ujlv6423n4r/1H3uAQqUbL7310NcBOM9CBZQDK4X/wsRCYjK7zoNYopW8cvlqA64G94sz5IzpRMVWTqtCPfLRppvXl+bd7A0kEn9TlTSX9Zc7sNQ6L3QC7aiNqShTK+SN/w0lw7w4VLEPqKDJu2SP8CXUPt1kMs6uJcrhWTu+v6zodCyNpk6s1K1GqxbZO+ceG/vDmOb/c52QotI6CJkRmoZo0K0D4wYfHYC+pLiD/9YO9PhAWt/l2S78DOOj/2vRAYdIJU+1+9mpSU5IL9jp17Y7okZZyssQRH2+QbTfb25oJmmsM84DrDNFs1DaGR839Jb/qzEoAy72mzrl7l/RbbxKIaCHmZDlyc5id0sEscF0LurtthR6JZChxlx/e3ggCIUhCtU6E9cb6t8LZeR6kqEwUYGaLPTRCl6n9gSWRGQBSwWr4KIrkg6Mf4jTI7GP1eBIdhSTNdRx2eUy/AR0geLocDzUyIgzXD9AAs+DGiHDLmthfh2m9DN2CVj/L43GlOLTF6vs8jtLsYJkZvnFPVOjl1UrV1v+0j5Mrv9Ojg4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB5922.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(366004)(136003)(376002)(451199015)(478600001)(7416002)(5660300002)(9686003)(8936002)(86362001)(316002)(38100700002)(7696005)(6506007)(6916009)(186003)(26005)(52536014)(54906003)(66946007)(4326008)(76116006)(66446008)(64756008)(71200400001)(66476007)(66556008)(2906002)(41300700001)(122000001)(55016003)(8676002)(83380400001)(38070700005)(33656002)(32563001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?N1D7RPWJxNMVmmCHBQNbnSBrL/5mMrXrGulJCWbq/P+nzcp0TjIgjyhsPi?=
 =?iso-8859-1?Q?0yFHAcY61Hzq4m+Qe+R9reT/8ZyvYN6HReIyMgx4tr4o0XR0yuRM42mgZI?=
 =?iso-8859-1?Q?ef0K5Kj2HNTLvFza//mok1gDlgebzfP8FwbrhAyXhy6kx8vP7NE0wojhMj?=
 =?iso-8859-1?Q?4wmYED5fusmewAZozJ0dvzLokBgsGi/EU2nFQ7U6fdyF9dhZ/tdCuYWZFl?=
 =?iso-8859-1?Q?wNyAmUMLZtyMQfgI+gvS7M2uwt1oCMeY4qyovUJcorRq5Y1g/0jVvZUDlb?=
 =?iso-8859-1?Q?3cE0qwH7pu94XWIpUaLOhGRRBr4TJmYW3L44yoS3keUVYebCjSl6mzh4v8?=
 =?iso-8859-1?Q?EUlc+1aY4Atv8vsTUIidQLbxYczGLWZHMhSpyQ2SYr2clTxL9amPss4sN4?=
 =?iso-8859-1?Q?MD1XLXE/NPOh+ixqJB49CE2thUUq91E6f6e19H6qIIwdtCiwcCudV3HW6/?=
 =?iso-8859-1?Q?/vnwNeRm2Tk2l/rC9WmQHa1ezU/D4suPHkqnT1DowQIKZ+T/5/9olKr/my?=
 =?iso-8859-1?Q?vW8GX3nZBlU5SEOYAYZJNlzJHnPjuyaXp6TXTC+sGTk4ESZye8jKGQelVg?=
 =?iso-8859-1?Q?4sFj/OU/oG6qXRMEOEJCjkNG9fj6hyCW7APlovbpzXFzdRDhP9P6fNRxef?=
 =?iso-8859-1?Q?662VKdbjiYrI7VKUYNRI9CeEGEoPH8JyVHYd9pwmmc8zKA7UIRuYVj5his?=
 =?iso-8859-1?Q?AHm4mmmUh+tcLWV8gS7uPHvnBfF40S2sNj/ZKp4kqlyuxZiHpCqOcMo/5J?=
 =?iso-8859-1?Q?uIkme4IYBUJ2m5ZI0iV3a0dIoBJ4eDOCi2242DdcldE4khsNutyHgwLUk8?=
 =?iso-8859-1?Q?4eAyWwvUW18gLUTmyweLPvWDamE1c/rbZTrrccYD2eCv8VpiBuV4S+1Szr?=
 =?iso-8859-1?Q?vnK5XEKi8T94XaIFCbc1myu0zJ3kewwi914SUtcVH8n6MK18wxnwqaFQXh?=
 =?iso-8859-1?Q?KluCzMoSmywjhI8INRCM5ZV2s62Hl1/9gewPo4oqpGx7FfWs1M/6t6M+dH?=
 =?iso-8859-1?Q?Fq0ywsFDHq6xQB8+Jd/ZKCFTFnplbOqeXWI/Nh7Zu97Oyqrf6jFm3wxC05?=
 =?iso-8859-1?Q?oMEBp5rymI9xnExd8N7lZyHns/bhxA5FkFzQNs3ZeDXim6HYIl2yCwx5H2?=
 =?iso-8859-1?Q?nuJ+4uEOZ0Hy2GcYFJbfWk9+SXLl51nbVPIxnLzmqe2gaXp1MfiSQyWVIX?=
 =?iso-8859-1?Q?YFCEMSDhACk7x04NzEZmYNhKZ4S/TAv3eClA7Q5NujaiWxLeHxAQJU0Jjj?=
 =?iso-8859-1?Q?OM63xjbVVjZp08odlYGvs+WG6LI6Jh9eVVa7ykF+Ro3xiswHiwsq4pth7x?=
 =?iso-8859-1?Q?B6r80+o3nlyBDjE/ucn0cJ+PMb4pnxZ0TGGQ4Li9ZEvWJHd3oCCBJRmSJE?=
 =?iso-8859-1?Q?2Z1SYVz5MZXMQZVkWDVH6Oqox5ipgsE20TbfMQAX1J/HSdVSWNB8kBC1e9?=
 =?iso-8859-1?Q?4HLWq6ZFxIMevAyLD8a8moP+RhWtdDBFQr13v3tcBZOdEX3D2H1AEjQ1sN?=
 =?iso-8859-1?Q?a6TBPrpgTKqYEYwHec/cKGJk/Am574x4QWQPZu3AF2WOEsEJ0NjEh4El5u?=
 =?iso-8859-1?Q?W/q35sB9n6fK5kBumtiAvqr8QlyU3JkBJvb96PmgMJkHxZFhg7dYc/4nU6?=
 =?iso-8859-1?Q?9oUCbtqUtGPLYkj40i/JgMyuJwGXG9E3K8?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB5922.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8b51e90-a4e9-4f6e-cc1e-08daa118c47a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2022 06:14:57.3859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GhiygONVVwQV8sa/ThGaZ2fWm5WjSPyJCV2W+gI5AmIE4mCCU9TRL8MnQ7YYjNW2bKRjathB6l3IO6X7/nKAp7y8j7xv1AnCsDiPCvrVSdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10102
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi William Breathitt Gray,

Thanks for the feedback.

> Subject: Re: [PATCH RFC 0/8] Add RZ/G2L MTU3a MFD and Counter driver
>=20
> On Mon, Sep 26, 2022 at 02:21:06PM +0100, Biju Das wrote:
> > The RZ/G2L multi-function timer pulse unit 3 (MTU3a) is embedded in
> > the Renesas RZ/G2L family SoC's. It consists of eight 16-bit timer
> > channels and one 32-bit timer channel. It supports the following
> > functions
> >  - Counter
> >  - Timer
> >  - PWM
> >
> > This patch series aim to add MFD and counter driver for MTU3a.
> > Subsequent patch seies will add TImer and PWM driver support also
> > enhancements to counter driver.
>=20
> Hello Biju,
>=20
> I see this device consists of several channels, but only one Count is
> defined in the counter patch ("Channel 1 Count"). Do all channels
> support counting, or is it limited to just one channel?

It is like this
MTU1 channel :- 1 16-bit phase counter
MTU2-Channel :- 1 16-bit phase counter
MTU1 + MTU2 channel combined:- 1 32-bit phase counter
Other channels are not supporting phase counting.

Each counter device will have 1 channel. Currently it supports
16-bit phase counting.

Please see my test program. Am I missing something here?

My test program:-

echo 1 > /sys/bus/counter/devices/counter0/count0/enable
echo 50 > /sys/bus/counter/devices/counter0/count0/ceiling
devmem2 0x10001391 b 0x00 # Enable phase clock selection A for MTU2.
echo 1 > /sys/bus/counter/devices/counter1/count0/enable
echo 50 > /sys/bus/counter/devices/counter1/count0/ceiling

for i in {1..5};
do cat /sys/bus/counter/devices/counter0/count0/count ;
cat /sys/bus/counter/devices/counter0/count0/direction;
cat /sys/bus/counter/devices/counter1/count0/count;
cat /sys/bus/counter/devices/counter1/count0/direction;
done

Cheers,
Biju
