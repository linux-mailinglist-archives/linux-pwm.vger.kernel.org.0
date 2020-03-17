Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 228F4188A31
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Mar 2020 17:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgCQQ04 (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 17 Mar 2020 12:26:56 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:34458 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgCQQ04 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 17 Mar 2020 12:26:56 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Claudiu.Beznea@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="Claudiu.Beznea@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Claudiu.Beznea@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Claudiu.Beznea@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: hiZgdZ5wt/s+H4xus3clYlfc8H3Oq+kIGETbH0Vmd1tCk+1PeKx6wDgeGGKGGEBhNzSGIdgNSG
 vP5XXb6SsLhYakhhXl/cHRj9L+ed0wQQe/9DqTGxjx6GGoefl+QLHXp1fQjp7M2o59K0MMjM5N
 7I/EBXuUNPxtgBIkV/PGGCo4R+8uyojo/0sPpG3cmZfIWkGryIUZP55CsiXAPsX3NieX175ejF
 R/ErTnG095oMB9vPF44NN7II+WesfyYp+gC2rHqioOAmMsi3MUcH8Ar53x2IQDXnztyMRKPBtL
 pBE=
X-IronPort-AV: E=Sophos;i="5.70,565,1574146800"; 
   d="scan'208";a="5953021"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Mar 2020 09:26:53 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 17 Mar 2020 09:26:53 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 17 Mar 2020 09:26:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KlEFxC+IfhHDXhsVgPEoqQcELVi/QrCc+hvIMCDhmw96PZgqgRpuxM7NVYxB++C12paY48UZfJw5y9uf76yRbT0DgtgQGexKG2+hzpio08DneFotLXDR3oSwcCgSfRryeCdCpb3pCsNGU18O7GJzmfxPueR27nSqWLr0w8EiRhIqllPLwstoSAKt7dNKe6KUI9UFJw5X0dWG/1zd8ludmrsTDHd9LtfiQkw0cHZumhhVEHtArz/qdnI2hMvril1r8iuv98eR6THaBw6Do3Zb6FLP1Iyxx5MaA3k2eKxH4a16NRj59Mb2qVthqEpPyxIAeYuUeWvnUXSUp2SMgrJnug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIzOciiFpPp1sQzpGEUBr6eHXjX2bEc2vxNCrPI5zN4=;
 b=HN+SCIe79XvpnJf/w0UsIQJZgCFdrWHo8wOyY3QiY/3V7wJ8kr1JuvQkD5xtt9d4YH6bh+eqofoGvV2cmqI6EzQU9PZgifTD+OkqoPT4gib4Zub4qcUAUaCbjo4LkNlDEHBwq24KapBEXuQNAgr2QQ7yqNqPGH/G1AQRt6qSk9h0rR640ZnN96GlMCgccBcpTXxVnzgC+qMTS7m0zxf9JVd/YfnYDwzfVdZaaVyRn3h+T23vvF6HN5J/2iRAbi7OiwsMYT7p7U7Tp2awzNvd8uR5F5+PZIPWIerhXjrQbOnC/MuOj8Blz2AnaXfQJf/nO0+hLWKc1UDuEMNRebm0lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EIzOciiFpPp1sQzpGEUBr6eHXjX2bEc2vxNCrPI5zN4=;
 b=b5Uaan6Ik2ujIYO18GUWOiuu/64lzJSiEGQlSr80Ssd9Vzxfh54A9rRsUbn9saMg2Tc5KRnz9zrG5W1sAQ1DQelNwbU2KcGhHdk+kHvBNxc6SqQ2UGDusxS93JTHYofFcOuv1jrrZeSXvIo9LeW3Sy27fh9Bhc7AZN+N/3gbgdM=
Received: from DM6PR11MB3225.namprd11.prod.outlook.com (2603:10b6:5:5b::32) by
 DM6PR11MB2603.namprd11.prod.outlook.com (2603:10b6:5:c6::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.13; Tue, 17 Mar 2020 16:26:50 +0000
Received: from DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::dc6b:1191:3a76:8b6a]) by DM6PR11MB3225.namprd11.prod.outlook.com
 ([fe80::dc6b:1191:3a76:8b6a%7]) with mapi id 15.20.2793.023; Tue, 17 Mar 2020
 16:26:50 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <oleksandr.suvorov@toradex.com>, <devicetree@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
CC:     <pbarker@konsulko.com>, <u.kleine-koenig@pengutronix.de>,
        <laurent.pinchart@ideasonboard.com>, <marcel.ziswiler@toradex.com>,
        <igor.opaniuk@toradex.com>, <philippe.schenker@toradex.com>,
        <alexandre.belloni@bootlin.com>, <wens@csie.org>,
        <festevam@gmail.com>, <f.fainelli@gmail.com>, <heiko@sntech.de>,
        <khilman@baylibre.com>, <Ludovic.Desroches@microchip.com>,
        <mripard@kernel.org>, <linux-imx@nxp.com>,
        <Nicolas.Ferre@microchip.com>, <palmer@dabbelt.com>,
        <paul@crapouillou.net>, <paul.walmsley@sifive.com>,
        <kernel@pengutronix.de>, <rjui@broadcom.com>,
        <s.hauer@pengutronix.de>, <sbranden@broadcom.com>,
        <shawnguo@kernel.org>, <thierry.reding@gmail.com>,
        <linux@prisktech.co.nz>, <bcm-kernel-feedback-list@broadcom.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
Subject: Re: [RFC PATCH 1/7] pwm: rename the PWM_POLARITY_INVERSED enum
Thread-Topic: [RFC PATCH 1/7] pwm: rename the PWM_POLARITY_INVERSED enum
Thread-Index: AQHV/Hjcr8D0wJ1/KU6yOYf2aNcyvA==
Date:   Tue, 17 Mar 2020 16:26:50 +0000
Message-ID: <f281a6a0-a150-514d-ef02-4e51192031d7@microchip.com>
References: <20200317123231.2843297-1-oleksandr.suvorov@toradex.com>
 <20200317123231.2843297-2-oleksandr.suvorov@toradex.com>
In-Reply-To: <20200317123231.2843297-2-oleksandr.suvorov@toradex.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
x-originating-ip: [86.126.9.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce6ecb69-76b3-43f3-fb04-08d7ca8fff34
x-ms-traffictypediagnostic: DM6PR11MB2603:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2603160B4E2BA59142F59D8A87F60@DM6PR11MB2603.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:218;
x-forefront-prvs: 0345CFD558
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(136003)(39860400002)(376002)(199004)(31696002)(4326008)(31686004)(2906002)(91956017)(76116006)(71200400001)(6486002)(66446008)(81166006)(86362001)(66946007)(7416002)(64756008)(66556008)(7406005)(66476007)(110136005)(81156014)(186003)(54906003)(478600001)(8676002)(26005)(8936002)(2616005)(6512007)(5660300002)(53546011)(4744005)(36756003)(6506007)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB2603;H:DM6PR11MB3225.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IHpw69mXXcfgiHzurM7j01zyT8PYjuTWrFBX/Z+gK4W2ArC6phY+due3PiwxkDWUKv/aNKTQhFbBtghnhHYeBL5PubIL31sYMPlaJR0E9mplKTQoCIY2SeuJ7Ghi3QLD9FEfW9i4EVjWTK5b3ZnhqWZmtVMRxKY/exnutU1ZGu3R41Obz5uraoM8L1Co9dHcRUprgyJKwujk318niv5n6yapwJDmtw3d7+KPEah5uAkKugV5tuvQSf1a/4q5SpChMBmVksNQYKVwt852WaA0QXFJnLFoGt2/hzO7nvYV6qlL8foEirpb2w6aajECFP4jJM7Y5Wcv+xdOvaB1ANPGwMmtsbQu+1+3bP1boerYTjirIZX+gaeGrgL0m7lgWI7IjDWLj4iwLhp6IColBaaWVP1rTCGJ7H9WcHk89yiFI25c920UA9dAIZZ5Y3qoPKXf
x-ms-exchange-antispam-messagedata: kVDFYKtTgbeYS4/dP8kT/ISXT3ss3Uh/024uKSW7TRN49m9cQG7UYpys52grIkIpPfeeaRiBY+rVggypZOr9Co1NuNWfPkthVNm35X2Ufv1xkSZ5+GtjTlgfbdYjWY/U1cRDlCzXSUKU09pZS+YTPw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <5888E88EB76E8649A10DB864BB54BC2E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6ecb69-76b3-43f3-fb04-08d7ca8fff34
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2020 16:26:50.4921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oNuGH8X6o35HIT2auDm4AePv5WhlN/Nxi9h7VsR/67IG1IIPszVehpt5idm0n1GLnIy3StHKTYF9jnzRxgboUWfeMkSaUoF+2w+zrflDOhI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2603
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

DQoNCk9uIDE3LjAzLjIwMjAgMTQ6MzIsIE9sZWtzYW5kciBTdXZvcm92IHdyb3RlOg0KPiBAQCAt
MTg3LDcgKzE4Nyw3IEBAIHN0YXRpYyBzc2l6ZV90IHBvbGFyaXR5X3N0b3JlKHN0cnVjdCBkZXZp
Y2UgKmNoaWxkLA0KPiAgICAgICAgIGlmIChzeXNmc19zdHJlcShidWYsICJub3JtYWwiKSkNCj4g
ICAgICAgICAgICAgICAgIHBvbGFyaXR5ID0gUFdNX1BPTEFSSVRZX05PUk1BTDsNCj4gICAgICAg
ICBlbHNlIGlmIChzeXNmc19zdHJlcShidWYsICJpbnZlcnNlZCIpKQ0KDQpZb3UgbWF5IGFsc28g
Y29uc2lkZXIgdGhpcyBzdHJpbmcgICAgIF4NCg0KPiAtICAgICAgICAgICAgICAgcG9sYXJpdHkg
PSBQV01fUE9MQVJJVFlfSU5WRVJTRUQ7DQo+ICsgICAgICAgICAgICAgICBwb2xhcml0eSA9IFBX
TV9QT0xBUklUWV9JTlZFUlRFRDs=
