Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74A6012220E
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2019 03:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfLQCmB (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Dec 2019 21:42:01 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:4351 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726539AbfLQCmA (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Dec 2019 21:42:00 -0500
X-UUID: 5bcf7bc8f628416ab668127b562673db-20191217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=N+05xpbfbBBsqYnJvXRE+vaAOXzjbDGQ8cCAfKizY18=;
        b=tUU4wRLlIcFo/H7h4mkm8bqg5/Ig1tVI8yH8tnRZZQ9iy8zVRv7xKIb8P64FbVk9oGIpGDucGmKYT/7qYAg0U9XMOpbGcrVIvD+4B+Nt7bj19bMtmSx5/rU52hY6/cfrvTzq2A2odp3ULZial+ib91yizF+WhZ3yMUVNqFzPdaQ=;
X-UUID: 5bcf7bc8f628416ab668127b562673db-20191217
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 350447063; Tue, 17 Dec 2019 10:41:56 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by mtkmbs05n1.mediatek.inc
 (172.21.101.15) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 17 Dec
 2019 10:41:38 +0800
Received: from [10.16.6.141] (172.27.4.253) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 17 Dec 2019 10:41:34 +0800
Message-ID: <1576550522.19567.1.camel@mszsdaap41>
Subject: Re: [PATCH v2 1/2] pwm: fine tune pwm-mtk-disp clock control flow
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, CK Hu <ck.hu@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <sj.huang@mediatek.com>
Date:   Tue, 17 Dec 2019 10:42:02 +0800
In-Reply-To: <20191216081843.yxe3vm674jwurwri@pengutronix.de>
References: <20191216070123.114719-1-jitao.shi@mediatek.com>
         <20191216070123.114719-2-jitao.shi@mediatek.com>
         <20191216081843.yxe3vm674jwurwri@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

T24gTW9uLCAyMDE5LTEyLTE2IGF0IDA5OjE4ICswMTAwLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90
ZToNCj4gSGVsbG8sDQo+IA0KPiBPbiBNb24sIERlYyAxNiwgMjAxOSBhdCAwMzowMToyMlBNICsw
ODAwLCBKaXRhbyBTaGkgd3JvdGU6DQo+ID4gTWF0Y2ggcHdtIGNsb2NrIHdoZW4gc3VzcGVuZCBh
bmQgcmVzdW1lLg0KPiA+IFByZXBhcmUgYW5kIGVuYWJsZSBkaXNwX3B3bSBjbG9jayB3aGVuIGRp
c3BfcHdtIGVuYWJsZS4NCj4gPiBEaXNhYmxlIGFuZCB1bnByZXBhcmUgZGlzcF9wd20gY2xvY2sg
d2hlbiBkaXNwX3B3bSBkaXNhYmxlLg0KPiANCj4gQXNzdW1pbmcgeW91IGNhdGNoZWQgYWxsIGNs
b2NrIG9wZXJhdGlvbnMgKEkgZGlkbid0IGNoZWNrKSwgdGhlIHBhdGNoDQo+IGxvb2tzIGZpbmUu
IFRoZSBjb21taXQgbG9nIGNvdWxkIGhvd2V2ZXIgYmUgaW1wcm92ZWQuIEFkZGl0aW9uYWwgdG8N
Cj4gZGVzY3JpYmluZyB3aGF0IHRoZSBwYXRjaCBkb2VzLCBzb21lIHdvcmRzIGFib3V0IHRoZSBt
b3RpdmF0aW9uIHdvdWxkIGJlDQo+IGdvb2QuIERvZXMgdGhpcyBmaXggYSBidWc/IElzIGl0IHRv
IHNhdmUgc29tZSBwb3dlciB3aGlsZSB0aGUgUFdNIGlzbid0DQo+IGluIHVzZT8NCj4gDQo+IEJl
c3QgcmVnYXJkcw0KPiBVd2UNCj4gDQoNCkknbGwgdXBkYXRlIHRoZSBjb21taXQgbXNnIG5leHQg
dmVyc2lvbi4NCg0KVGhhbmtzIGZvciB5b3VyIHJldmlldy4NCg0KQmVzdCBSZWdhcmRzDQpKaXRh
bw0K

