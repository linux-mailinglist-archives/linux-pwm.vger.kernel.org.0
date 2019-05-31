Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2B330BA0
	for <lists+linux-pwm@lfdr.de>; Fri, 31 May 2019 11:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfEaJbo (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Fri, 31 May 2019 05:31:44 -0400
Received: from mail-eopbgr1400103.outbound.protection.outlook.com ([40.107.140.103]:49381
        "EHLO JPN01-TY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727198AbfEaJbo (ORCPT <rfc822;linux-pwm@vger.kernel.org>);
        Fri, 31 May 2019 05:31:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=renesasgroup.onmicrosoft.com; s=selector2-renesasgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yNarsrIAppBinrysfWXLQYOFUSxktQ6AeOg4yuW5kE=;
 b=WQyGL4RkaXKp3NE4qQigWR4RqU/frHVn1oPtWsIW+unsjigwRv+xipmB+k/soSiMUL6OYVGYT1uYQknEGZkKfnRfVJcI/eARnjhHW0kD6I1vbUtOwnfessFigEBZ5FK23by8jufoCN+9A1ngIC3gii6hbASesejlhFLO5a1VED4=
Received: from OSAPR01MB3089.jpnprd01.prod.outlook.com (52.134.247.150) by
 OSAPR01MB1457.jpnprd01.prod.outlook.com (52.134.230.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.22; Fri, 31 May 2019 09:31:39 +0000
Received: from OSAPR01MB3089.jpnprd01.prod.outlook.com
 ([fe80::4597:5353:28fb:cfd8]) by OSAPR01MB3089.jpnprd01.prod.outlook.com
 ([fe80::4597:5353:28fb:cfd8%7]) with mapi id 15.20.1922.017; Fri, 31 May 2019
 09:31:39 +0000
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Linux PWM List <linux-pwm@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v2 1/4] pwm: Add power management descriptions
Thread-Topic: [PATCH v2 1/4] pwm: Add power management descriptions
Thread-Index: AQHVFtFhq6z+bSHcO0CWeYpHfVWWtqaE1OgAgAAgImCAAAPYAIAAAHtA
Date:   Fri, 31 May 2019 09:31:39 +0000
Message-ID: <OSAPR01MB3089B5CCB42A92EA191733DCD8190@OSAPR01MB3089.jpnprd01.prod.outlook.com>
References: <1559211367-25106-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <1559211367-25106-2-git-send-email-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdVjOuvUyX3QJP-DOmYt3wzt3NOioDfm_CQhyZvOnGgy6Q@mail.gmail.com>
 <OSAPR01MB3089658CD2E8DF789BA7737FD8190@OSAPR01MB3089.jpnprd01.prod.outlook.com>
 <CAMuHMdUkYChEX+uaxqAhHRTDKPST9HZNqOKGTf2kxM0F+_nsxQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUkYChEX+uaxqAhHRTDKPST9HZNqOKGTf2kxM0F+_nsxQ@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yoshihiro.shimoda.uh@renesas.com; 
x-originating-ip: [118.238.235.108]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0377382-1c76-4105-c5ca-08d6e5aac8d6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:OSAPR01MB1457;
x-ms-traffictypediagnostic: OSAPR01MB1457:
x-microsoft-antispam-prvs: <OSAPR01MB14578D2E1F49D48BA7D8DCACD8190@OSAPR01MB1457.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-forefront-prvs: 00540983E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(366004)(39860400002)(199004)(189003)(6246003)(186003)(76116006)(66946007)(73956011)(7736002)(4326008)(99286004)(55016002)(66066001)(66476007)(3846002)(446003)(33656002)(66446008)(81156014)(486006)(66556008)(81166006)(6436002)(9686003)(8936002)(64756008)(68736007)(229853002)(476003)(6116002)(26005)(11346002)(7696005)(53936002)(8676002)(316002)(86362001)(6506007)(5660300002)(76176011)(71200400001)(256004)(305945005)(54906003)(14454004)(2906002)(25786009)(71190400001)(53546011)(74316002)(52536014)(102836004)(6916009)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:OSAPR01MB1457;H:OSAPR01MB3089.jpnprd01.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: renesas.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MrUgXbf6PatMuwlfvGP9u1nXk/uG+x3ZR2sy4YEG+GQmGdeJ5eM3wsZcQ84P7M/vMg6WCH6/K7guif/i+GFiC0meVIl/v3EAJpZb95+hwl8yFk7PtcvfB/CFSkCTpnJ7UIW1DCKLahGTu1t9W2FDXwB9Tx0jelvhYD2DbS5xvxq4pgJkGYWb1QaRqmJwsVmUyCZLjdeIuRsNPCOanZ6gScFRlF6AKaXoC5gSf7q2eLtRzUoX2eZuG+46FUW+wClSmVPHLhqosCLtxo21MpNo2F9xQZTwVoS4NjJK898Bhq/yEtA3UOPnWQil5VQ4nkIYW1cwwvJkohxRdYtX/df8V+eLeA4a1JUXk/UYSLV8hkv3tTVeKlmJkhtV7X7+CuOhs9otPPZmqvNgfZtLH372xjDsHv+yQc+XxUUxjv6WW94=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0377382-1c76-4105-c5ca-08d6e5aac8d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2019 09:31:39.5273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yoshihiro.shimoda.uh@renesas.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1457
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGkgR2VlcnQtc2FuLA0KDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiwgU2VudDogRnJpZGF5
LCBNYXkgMzEsIDIwMTkgNjoyOSBQTQ0KPiANCj4gSGkgU2hpbW9kYS1zYW4sDQo+IA0KPiBPbiBG
cmksIE1heSAzMSwgMjAxOSBhdCAxMToyMiBBTSBZb3NoaWhpcm8gU2hpbW9kYQ0KPiA8eW9zaGlo
aXJvLnNoaW1vZGEudWhAcmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+ID4gT24gVGh1LCBNYXkgMzAs
IDIwMTkgYXQgMTI6MjEgUE0gWW9zaGloaXJvIFNoaW1vZGENCj4gPiA+IDx5b3NoaWhpcm8uc2hp
bW9kYS51aEByZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gPiA+IFRoaXMgcGF0Y2ggYWRkcyBwb3dl
ciBtYW5hZ2VtZW50IGRlc2NyaXB0aW9ucyB0aGF0IGNvbnN1bWVycyBzaG91bGQNCj4gPiA+ID4g
aW1wbGVtZW50IGl0Lg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBZb3NoaWhpcm8g
U2hpbW9kYSA8eW9zaGloaXJvLnNoaW1vZGEudWhAcmVuZXNhcy5jb20+DQo+ID4gPg0KPiA+ID4g
VGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KPiA+ID4NCj4gPiA+ID4gLS0tIGEvRG9jdW1lbnRhdGlv
bi9wd20udHh0DQo+ID4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vcHdtLnR4dA0KPiA+ID4NCj4g
PiA+ID4gQEAgLTE0MSw2ICsxNDUsOSBAQCBUaGUgaW1wbGVtZW50YXRpb24gb2YgLT5nZXRfc3Rh
dGUoKSAoYSBtZXRob2QgdXNlZCB0byByZXRyaWV2ZSBpbml0aWFsIFBXTQ0KPiA+ID4gPiAgc3Rh
dGUpIGlzIGFsc28gZW5jb3VyYWdlZCBmb3IgdGhlIHNhbWUgcmVhc29uOiBsZXR0aW5nIHRoZSBQ
V00gdXNlciBrbm93DQo+ID4gPiA+ICBhYm91dCB0aGUgY3VycmVudCBQV00gc3RhdGUgd291bGQg
YWxsb3cgaGltIHRvIGF2b2lkIGdsaXRjaGVzLg0KPiA+ID4gPg0KPiA+ID4gPiArRHJpdmVycyBz
aG91bGQgbm90IGltcGxlbWVudCBhbnkgcG93ZXIgbWFuYWdlbWVudC4gSW4gb3RoZXIgd29yZHMs
DQo+ID4gPiA+ICtjb25zdW1lcnMgc2hvdWxkIGltcGxlbWVudCBpdCBhcyBkZXNjcmliZWQgYXMg
dGhlICJVc2luZyBQV01zIiBzZWN0aW9uLg0KPiA+ID4NCj4gPiA+IHMvYXMvaW4vDQo+ID4NCj4g
PiBTbywgIi4uLiBpbiBkZXNjcmliZWQgYXMgLi4uIiA/DQo+ID4NCj4gPiBJJ20gbm90IGEgbmF0
aXZlIHNwZWFrZXIsIHNvIHRoYXQgYW55IGNhc2VzIGJlbG93IHNlZW0gbm90IHNvIGRpZmZlcmVu
dCB0byBtZSA6KQ0KPiA+DQo+ID4gMS4gIi4uLiBhcyBkZXNjcmliZWQgYXMgLi4uIg0KPiA+IDIu
ICIuLi4gaW4gZGVzY3JpYmVkIGFzIC4uLiINCj4gPiAzLiAiLi4uIGFzIGRlc2NyaWJlZCBpbiAu
Li4iDQo+ID4gNC4gIi4uLiBpbiBkZXNjcmliZWQgaW4gLi4uIg0KPiANCj4gU29ycnkgZm9yIGJl
aW5nIHVuY2xlYXI6ICIuLi4gYXMgZGVzY3JpYmVkIGluIC4uLiINCg0KVGhhbmsgeW91IGZvciB0
aGUgcmVwbHkhIEknbGwgcmV2aXNlIGl0Lg0KDQpCZXN0IHJlZ2FyZHMsDQpZb3NoaWhpcm8gU2hp
bW9kYQ0KDQo+IEdye29ldGplLGVldGluZ31zLA0KPiANCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgR2VlcnQNCj4gDQo+IC0tDQo+IEdlZXJ0IFV5dHRlcmhvZXZlbiAtLSBUaGVyZSdzIGxvdHMg
b2YgTGludXggYmV5b25kIGlhMzIgLS0gZ2VlcnRAbGludXgtbTY4ay5vcmcNCj4gDQo+IEluIHBl
cnNvbmFsIGNvbnZlcnNhdGlvbnMgd2l0aCB0ZWNobmljYWwgcGVvcGxlLCBJIGNhbGwgbXlzZWxm
IGEgaGFja2VyLiBCdXQNCj4gd2hlbiBJJ20gdGFsa2luZyB0byBqb3VybmFsaXN0cyBJIGp1c3Qg
c2F5ICJwcm9ncmFtbWVyIiBvciBzb21ldGhpbmcgbGlrZSB0aGF0Lg0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIC0tIExpbnVzIFRvcnZhbGRzDQo=
