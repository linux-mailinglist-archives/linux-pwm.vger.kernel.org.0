Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1796524655B
	for <lists+linux-pwm@lfdr.de>; Mon, 17 Aug 2020 13:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgHQL2u (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 17 Aug 2020 07:28:50 -0400
Received: from mail-eopbgr1300091.outbound.protection.outlook.com ([40.107.130.91]:8864
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726135AbgHQL2s (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Mon, 17 Aug 2020 07:28:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxeyOosHre6MyH/BEHZqqzQrGRtoe4/OMobNl4kyl/X+mH38XM3Vw3YwUL21YYbk5ffyx+u1T2rybJobX3AB9ExMlGA4Tr8tHcxk78V2DEoV2YPbb2s1jfqM1EKuL62kCX/jl/h2DnDIaxdYeulQNwYuIbE06ep/jV3rmTQX4zQH6lRvX1r6hibyjVGWNCEKYBYGdy9y+osLEiuzpU9ozsg0X1pX50ff1huFD43KWHIUvDfa75wS6b32x25Bpid3dfLFVl+PLnM4HVcY7o8ap09cIuw1ruGaxZRNiYsmu0FyMncjyyA0rr++6rAO9IVZP0Ud7St4DRsdFThUexmseA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rn8JADMtXo+GTtizT0feGz+sNHaaOqJIV0GNlbmMXCE=;
 b=Peuw0ibhfevIYEbZBLWH6JDbSWLKgKpZGs8/4Wfm9qwThDY1qb1khWb+BGmZTFJieSGlWk6VzQmdoCq4FatgiRg8PkdYV5szuBwjlj1CGurN88fFGxxjLBbZ8vOB44utjWrk+TO5ifBGDegRVZxbSjeU347TITHFKY1U9843mrdA7VLgfMNPa5RnC92h0QKz2KdHG83CFDFXdrKdqMbIbQKQfDezhLMYg4vBiYqfhDbI5N3Ro2LQ9cegENBnuvWiV+74wdujhOhlJpOnCCN+ikMSp8cZ0OY1i2QBt4OqJQ/xx/OpcddiEStvgc9CRdTF6yV3CRRxbbQIY2MjlbJr0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rn8JADMtXo+GTtizT0feGz+sNHaaOqJIV0GNlbmMXCE=;
 b=RH5+iuOrLFQiydBZtunndTy77y5Au+eQda5nZd1N8TlFaN8QFJ7vrIYGydWRQSWE3iAKRqLtsUg/TeZDuq5HapaNdkf+u6qV7WJX5yIVIp2ZHSfxiJLzuIho1V5rid4Izbzaea9aSHld1TLAmJcqiVGQSrw59xPtpVMnspJs70k=
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com (2603:1096:404:d5::22)
 by TY2PR01MB4300.jpnprd01.prod.outlook.com (2603:1096:404:10b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15; Mon, 17 Aug
 2020 11:28:43 +0000
Received: from TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::9083:6001:8090:9f3]) by TY2PR01MB3692.jpnprd01.prod.outlook.com
 ([fe80::9083:6001:8090:9f3%6]) with mapi id 15.20.3283.027; Mon, 17 Aug 2020
 11:28:42 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 2/5] dt-bindings: pwm: renesas,pwm-rcar: Add r8a7742
 support
Thread-Topic: [PATCH 2/5] dt-bindings: pwm: renesas,pwm-rcar: Add r8a7742
 support
Thread-Index: AQHWbB/iovw0ETBN5E6t+4f0EkNPa6k8OqdA
Date:   Mon, 17 Aug 2020 11:28:42 +0000
Message-ID: <TY2PR01MB36923FC9D99F2F088531086AD85F0@TY2PR01MB3692.jpnprd01.prod.outlook.com>
References: <20200806183152.11809-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200806183152.11809-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200806183152.11809-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: bp.renesas.com; dkim=none (message not signed)
 header.d=none;bp.renesas.com; dmarc=none action=none header.from=renesas.com;
x-originating-ip: [240f:60:5f3e:1:3806:c8ab:968a:d05d]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 840515d9-9c49-4956-5b30-08d842a0b281
x-ms-traffictypediagnostic: TY2PR01MB4300:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB4300BCAA5BA8725C9EC430ABD85F0@TY2PR01MB4300.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lx7MlDyK0sL9QhtFYkuk/XnUIOYxvwzSCf7FoFXHgB+mQ4EPJW+12T4Z0KbXEZBphqjrP6fZ/OPN70NlTr+RERHFpBidq6Z3fJ/j4F3CXFuStl5QGN7F57/0vd6wwO73Hscnj44+hJJFMcLGvXrCqWB8QLT0eNdzQ/sUL+Axo3/zGgLHCwwlylS1Di3SO4hftOdTLjOkrZBcCmrDCwY+JYEVOZSZ+VYcAnnc5zuZNp0Cbvo+aigOUDjbQpnHlSnau51Qpqsj8hRhlXzB0Pmioc99ofDmglFT0fpqRmeNbqmq6w13dSJwTtBx/vl2wzopf5nggJyQ9MjTU2tjw6e8m0cLqFCsLqUpWUsxrVEjXxk6n0mBZCHbulgK2ZCQj8rD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB3692.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(4326008)(6506007)(5660300002)(33656002)(316002)(52536014)(66946007)(8936002)(55016002)(478600001)(66556008)(66476007)(64756008)(76116006)(86362001)(110136005)(9686003)(66446008)(186003)(8676002)(7416002)(2906002)(7696005)(107886003)(71200400001)(558084003)(54906003)(142933001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: cw9djeJ/88pL11pR3Z/gGEUCy7lJP+am3ywAEcdRp09ySgcRPdf1JXAsweXeStSudkPH6pnO6sI8Q1tfGa32VgBZFS+ExCcm7k65j1FWm3U6l85VW5aKsqVW0SxCjdbPK03fsICvLxYeKnZMRwdb8KODzKA5qMyZHr0QweY/+I8YMzyB3vEMZTaQf145e6nCwxorNTvMsRvkj0Kwj5ePIzdAnSai4Hb/6NRBBQ4IFLU6soy2qcTWjvmrS+dW2gJKlU5odx4hpSqxx91jhtzUyuN+XWpCJGOC+Zb2SAD809fy5bDL0x9q195nR9Io+LD6SXKI3oGMwZW4t2oLo6QPNvJSBKAj28b8PN4yoJg+vVfYs1p+1Q3cNHbMJcTr2WL2lrG8UTDHdOWyGkR4KJb9BYhq0S/PIaXH07Yf39oCui4FeE0odWM7hJ3sxen5Tp+OlmddY4xSSsggsYhQK3QpQBM35whNgUT/Rrlg2YLJ/FWPqWtVS7LxNr3F/KUQD0/LbvDBPCq0Y0b5C/6oX4sh8PtfaZv1v30qC6dikeKjPfRFqA+1zyJz+15NlNCIXdL8PwUWH0c+PwEXLDKwcjLM40Z5j2131ux3Qr+Z0dbPMbeENyszDVnkgFczf+UEMKPBOZcTlT78/SPKUFFYrF8+piPkgF/STshqW/y8fcsJyllZqS8urtNjmn0FWn+GdE4V7Tgsca620jrHxCrcWEDSZA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB3692.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 840515d9-9c49-4956-5b30-08d842a0b281
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2020 11:28:42.8538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mjc2QAPjyVkW9pjxXZf2PLQUPUclKOSb57JaRCYsfHRvnpqHYvlgxZrFCUOcDIWKY3DdT04AtIY9B2jXJzARuAtZ98h9gx7Z3nKYPitKVWek8+4ek8dlsl/8XcS3dx6N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4300
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Lad-san,

> From: Lad Prabhakar, Sent: Friday, August 7, 2020 3:32 AM
>=20
> Document RZ/G1H (R8A7742) SoC bindings.
>=20
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renes=
as.com>

Thank you for your patch!

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Best regards,
Yoshihiro Shimoda

