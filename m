Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE6A2390E11
	for <lists+linux-pwm@lfdr.de>; Wed, 26 May 2021 03:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhEZBzm (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 May 2021 21:55:42 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:17593 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231707AbhEZBzl (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 May 2021 21:55:41 -0400
X-UUID: fdfacc859694470b90309409b7444d80-20210526
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=OL48yFH+2xYnJfSiWPGce5BsZriz5riusFvvUVxlXRA=;
        b=Hg8WFYY70UW92/2ZHEGcE9V/MEOHgjeV6RRGnirxm6pGpYhoulBOk0oUp/f8Ilm44p7vwYF2MyC6U4o8CkMJ0UC9EGB1+1WPpS3BLx4RY/GRjYQXvefWEPF7gcx0XJqHcWkj8kxAcskv/hBShyKq6I1LHMZa9lmLrIk+jmJDUZU=;
X-UUID: fdfacc859694470b90309409b7444d80-20210526
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 389015561; Wed, 26 May 2021 09:54:08 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 26 May
 2021 09:54:04 +0800
Received: from [10.16.6.141] (10.16.6.141) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 26 May 2021 09:54:03 +0800
Message-ID: <1621994043.32080.9.camel@mszsdaap41>
Subject: Re: [PATCH v2 1/3] pwm: mtk_disp: clear the clock operations
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Yingjoe Chen =?UTF-8?Q?=28=E9=99=B3=E8=8B=B1=E6=B4=B2=29?= 
        <Yingjoe.Chen@mediatek.com>,
        Eddie Huang =?UTF-8?Q?=28=E9=BB=83=E6=99=BA=E5=82=91=29?= 
        <eddie.huang@mediatek.com>,
        Cawa Cheng =?UTF-8?Q?=28=E9=84=AD=E6=9B=84=E7=A6=A7=29?= 
        <cawa.cheng@mediatek.com>,
        Bibby Hsieh =?UTF-8?Q?=28=E8=AC=9D=E6=BF=9F=E9=81=A0=29?= 
        <Bibby.Hsieh@mediatek.com>,
        CK Hu =?UTF-8?Q?=28=E8=83=A1=E4=BF=8A=E5=85=89=29?= 
        <ck.hu@mediatek.com>, "stonea168@163.com" <stonea168@163.com>,
        Huijuan Xie =?UTF-8?Q?=28=E8=B0=A2=E6=85=A7=E5=A8=9F=29?= 
        <Huijuan.Xie@mediatek.com>
Date:   Wed, 26 May 2021 09:54:03 +0800
In-Reply-To: <YDO/0Onf6a09YRsP@ulmo.localdomain>
References: <20210130141226.25357-1-jitao.shi@mediatek.com>
         <20210130141226.25357-2-jitao.shi@mediatek.com>
         <YDO/0Onf6a09YRsP@ulmo.localdomain>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: EAF69C26BC8B6484722F8C014C612CE0297C6B427E74CF4A88B0DBC3B5786F2F2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

T24gTW9uLCAyMDIxLTAyLTIyIGF0IDIyOjI5ICswODAwLCBUaGllcnJ5IFJlZGluZyB3cm90ZToN
Cj4gT24gU2F0LCBKYW4gMzAsIDIwMjEgYXQgMTA6MTI6MjRQTSArMDgwMCwgSml0YW8gU2hpIHdy
b3RlOg0KPiA+IFJlbW92ZSB0aGUgY2xrX3ByZXBhcmUgZnJvbSBtdGtfZGlzcF9wd21fcHJvYmUu
DQo+ID4gUmVtb3ZlIHRoZSBjbGtfdW5wcmVwYXJlIGZyb20gbXRrX2Rpc3BfcHdtX3JlbW92ZS4N
Cj4gPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKaXRhbyBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5j
b20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcHdtL3B3bS1tdGstZGlzcC5jIHwgMjMgKystLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwg
MjEgZGVsZXRpb25zKC0pDQo+IA0KPiBJdCdzIG5vdCBjbGVhciAqd2h5KiB5b3UncmUgZG9pbmcg
dGhpcyBjaGFuZ2UuIEl0J3MgYWxyZWFkeSBvYnZpb3VzIGZyb20NCj4gdGhlIGNoYW5nZXMgaW4g
dGhpcyBwYXRjaCB0aGF0IHlvdSdyZSByZW1vdmluZyB0aGUgY2FsbHMgdG8NCj4gY2xrX3ByZXBh
cmUoKSBhbmQgY2xrX3VucHJlcGFyZSgpLCBzbyBpbnN0ZWFkIG9mIGR1cGxpY2F0aW5nIHRoYXQN
Cj4gaW5mb3JtYXRpb24gaW4gdGhlIGNvbW1pdCBtZXNzYWdlLCB0YWtlIHRoaXMgb3Bwb3J0dW5p
dHkgdG8gZGVzY3JpYmUgd2h5DQo+IHRoaXMgY2hhbmdlIGlzIG5lZWRlZC4gV2l0aG91dCBhbnkg
ZnVydGhlciBjb250ZXh0LCB0aGlzIHdvdWxkIHNlZW0gdG8NCj4ganVzdCBicmVhayBvcGVyYXRp
b24gb2YgdGhpcyBjaGlwIGJlY2F1c2Ugbm93IHRoZXNlIGNsb2NrcyBhcmUgbmV2ZXINCj4gZW5h
YmxlZCBpbiB0aGUgZmlyc3QgcGxhY2UuDQo+IA0KPiBUaGllcnJ5DQoNClRoYW5rcyBmb3IgeW91
ciByZXZpZXcuDQoNCkknbGwgdXBkYXRlIHRoZSBjb21taXQgbWVzc2FnZSBuZXh0IHZlcnNpb24u
DQoNClRoZSBvcmlnaW5hbCBpc3N1ZSBpcyB0aGUgY2xvY2tzIGRvZXNuJ3QgYmUgZGlzYWJsZWQg
d2hlbiBzeXN0ZW0gZW50ZXINCnN0YW5kYnkuDQoNClRoZW4gSSBhZGp1c3QgdGhlIHRoZSBjbG9j
ayBzZXF1ZW5jZS4gYW5kIFV3ZSBzdWJqZWN0IGNvbnZlcnQgdGhlbGVnYWN5DQpBUElzIG9mIC5h
cHBseSgpLg0K

