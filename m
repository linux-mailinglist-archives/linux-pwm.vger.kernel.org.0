Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1D281222BD
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2019 04:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfLQD4c (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Dec 2019 22:56:32 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:50203 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726296AbfLQD4c (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Dec 2019 22:56:32 -0500
X-UUID: b4e0593fd24b49e28bff3763b079efa4-20191217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=KkmyAsKPyDcGBnKBUKfiIEN/q+ZFhqtz1dZUrUzasmY=;
        b=AQu47qdPYZ4rF19lIlMz96C/lzXnNcMWCmHvcKFBkN7ia+QDja/BWIQIJW7UscKdZo3hO4NxmAstqoAkxAbdoihaaUCMBxVawqE+Mxhl3qXjOH0tqFx87ArUwOMysDtM+cMOaxahDPJDxXDGBut14LYojDIF9NdizBocgGR+ibU=;
X-UUID: b4e0593fd24b49e28bff3763b079efa4-20191217
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1777341739; Tue, 17 Dec 2019 11:56:22 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs05n2.mediatek.inc
 (172.21.101.140) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 17 Dec
 2019 11:55:59 +0800
Received: from [10.16.6.141] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 17 Dec 2019 11:55:59 +0800
Message-ID: <1576554988.19567.3.camel@mszsdaap41>
Subject: Re: [PATCH v3 0/2] clocks don't disable when pwm_mtk_disp suspend
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Chen-Yu Tsai <wens@kernel.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pwm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        CK Hu <ck.hu@mediatek.com>, <sj.huang@mediatek.com>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 17 Dec 2019 11:56:28 +0800
In-Reply-To: <CAGb2v65v+W3-fNwiC_0uN2RpFUBRu3iL2t+OaGHLjVHHWFJVwQ@mail.gmail.com>
References: <20191217030438.26657-1-jitao.shi@mediatek.com>
         <CAGb2v65v+W3-fNwiC_0uN2RpFUBRu3iL2t+OaGHLjVHHWFJVwQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

T24gVHVlLCAyMDE5LTEyLTE3IGF0IDExOjI2ICswODAwLCBDaGVuLVl1IFRzYWkgd3JvdGU6DQo+
IEhpLA0KPiANCj4gT24gVHVlLCBEZWMgMTcsIDIwMTkgYXQgMTE6MDggQU0gSml0YW8gU2hpIDxq
aXRhby5zaGlAbWVkaWF0ZWsuY29tPiB3cm90ZToNCj4gPg0KPiA+IENoYW5nZXMgc2luY2UgdG8g
djI6DQo+ID4gIC0gRWRpdCBjb21taXQgbXNnLg0KPiA+DQo+ID4gQ2hhbmdlcyBzaW5jZSB0byB2
MToNCj4gPiAgLSBFZGl0IGNvbW1pdCBtc2cuDQo+ID4gIC0gUmVtb3ZlIHRoZSByZWdpc3RlciB0
cmlnZ2VyIGluIHByb2JlLg0KPiA+ICAtIFJlYmFzZSB0byB2NS41LXJjMS4NCj4gPg0KPiA+IENo
YW5nZXMgaW4gcGF0Y2hlczoNCj4gPiAgLSBtYXRjaCBwd21fbXRrX2Rpc3AgY2xvY2sgd2hlbiBz
dXNwZW5kL3Jlc3VtZQ0KPiA+ICAtIHRyaWdnZXIgcHdtX210a19kaXNwIHJlZyB3b3JraW5nIGFm
dGVyIGNvbmZpZw0KPiA+DQo+ID4gSml0YW8gU2hpICgyKToNCj4gPiAgIHB3bTogZml4IHB3bSBj
bG9ja3Mgbm90IHBvd2Vyb2ZmIHdoZW4gZGlzYWJsZSBwd20NCj4gPiAgIHB3bToga2VlcCB0aGUg
dHJpZ2dlciByZWdpc3RlciBhZnRlciBwd20gc2V0dGluZy4NCj4gDQo+IFBsZWFzZSBhZGQgYXBw
cm9wcmlhdGUgdGFncyB0byB5b3VyIHBhdGNoZXMuIFRoZXNlIGFyZSBub3QgZ2VuZXJpYyBwd20N
Cj4gcGF0Y2hlcywgYnV0IGFyZSBzcGVjaWZpYyB0byBvbmUgZHJpdmVyLg0KPiANCj4gQ29uc2lk
ZXIgdGhlIHByZWZpeDogInB3bTogbXRrLWRpc3A6ICIgc28gb3RoZXJzIGNhbiBmaWx0ZXIgb3V0
IHRoZQ0KPiBub2lzZSB3aXRob3V0IGxvb2tpbmcgYXQgdGhlIGNvbnRlbnQuDQo+IA0KPiBDaGVu
WXUNCg0KT0suIEknbGwgZml4IHRoaXMgcHJlZml4Lg0KDQpCZXN0IFJlZ2FyZHMNCkppdGFvDQo+
IA0KPiA+DQo+ID4gIGRyaXZlcnMvcHdtL3B3bS1tdGstZGlzcC5jIHwgNjMgKysrKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2Vy
dGlvbnMoKyksIDQ0IGRlbGV0aW9ucygtKQ0KPiA+DQo+ID4gLS0NCj4gPiAyLjIxLjANCj4gPiBf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiA+IGxpbnV4
LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0DQo+ID4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnDQo+ID4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5m
by9saW51eC1hcm0ta2VybmVsDQoNCg==

