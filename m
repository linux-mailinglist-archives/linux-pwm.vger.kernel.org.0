Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3474C17D849
	for <lists+linux-pwm@lfdr.de>; Mon,  9 Mar 2020 04:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgCIDfy (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 8 Mar 2020 23:35:54 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:22526 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726352AbgCIDfy (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 8 Mar 2020 23:35:54 -0400
X-UUID: 8e2c851f376f42a38f3789f6b06f7bf0-20200309
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=NPplXrKgtKtz1x0Ix8YmImoSvkv1+1IC9efSsIgz5rA=;
        b=sV0mNfSJjS+svi/9q1NwYqHr4RZWLuxhCKB0eLroOX/wZXNm/TC6aZY/7H6MiaA1xGuyuxp7Dlk/OtE3hTAC/SZeNEaD36hd9l52IL5CPMdqHLjt/lB+40RlMcM5NECuZfPVN6nRL3/zUEDhTEMlsXZ8fsC2LeBNR7NRg+vU+JY=;
X-UUID: 8e2c851f376f42a38f3789f6b06f7bf0-20200309
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1428586009; Mon, 09 Mar 2020 11:35:43 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 9 Mar 2020 11:35:41 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 9 Mar 2020 11:35:38 +0800
Message-ID: <1583724941.15393.8.camel@mtksdccf07>
Subject: Re: [PATCH v2 1/1] pwm: mediatek: add longer period support
From:   Sam Shih <sam.shih@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        "Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?=" 
        <u.kleine-koenig@pengutronix.de>
CC:     <linux-pwm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        <linux-mediatek@lists.infradead.org>,
        "John Crispin" <john@phrozen.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Mon, 9 Mar 2020 11:35:41 +0800
In-Reply-To: <20200308201811.hlac57s3h4p4cgev@pengutronix.de>
References: <1583230755-25986-1-git-send-email-sam.shih@mediatek.com>
         <1583230755-25986-2-git-send-email-sam.shih@mediatek.com>
         <1a3a523e-62ff-e380-c67b-12f742d348ea@gmail.com>
         <20200308201811.hlac57s3h4p4cgev@pengutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: BF9287628D924EBECDF23B1AA8716029622345E5AC47F06F0882C90E7795C30A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

SGVsbG8sDQoNCk9uIFN1biwgMjAyMC0wMy0wOCBhdCAyMToxOCArMDEwMCwgVXdlIEtsZWluZS1L
9m5pZyB3cm90ZToNCj4gSGVsbG8sDQo+IA0KPiBPbiBTYXQsIE1hciAwNywgMjAyMCBhdCAxMDoy
ODozNlBNICswMTAwLCBNYXR0aGlhcyBCcnVnZ2VyIHdyb3RlOg0KPiA+IE9uIDAzLzAzLzIwMjAg
MTE6MTksIFNhbSBTaGloIHdyb3RlOg0KPiA+ID4gVGhlIHB3bSBjbG9jayBzb3VyY2UgY291bGQg
YmUgZGl2aWRlZCBieSAxNjI1IHdpdGggUFdNX0NPTg0KPiA+ID4gQklUKDMpIHNldHRpbmcgaW4g
bWVkaWF0ZWsgaGFyZHdhcmUuDQo+ID4gPiANCj4gPiA+IFRoaXMgcGF0Y2ggYWRkIHN1cHBvcnQg
Zm9yIGxvbmdlciBwd20gcGVyaW9kIGNvbmZpZ3VyYXRpb24sDQo+ID4gPiB3aGljaCBhbGxvd2lu
ZyBibGlua2luZyBMRURzIHZpYSBwd20gaW50ZXJmYWNlLg0KPiA+IA0KPiA+IElzIHRoaXMgYSBm
aXg/IEluIHRoaXMgY2FzZSBwbGVhc2UgcHJvdmlkZSBhIEZpeGVzIHRhZyB3aXRoIHRoZSBjb21t
aXQgSUQgd2hpY2gNCj4gPiBpbnRyb2R1Y2VkIHRoZSBidWcuDQo+IA0KPiBJJ2Qgc2F5IGl0IHF1
YWxpZmllcyBhcyBhIGZpeCBpZiB3aXRob3V0IGl0IGEgcmVxdWVzdCB3aXRoIGEgbG9uZyBwZXJp
b2QNCj4gcmV0dXJucyBzdWNjZXNzIGJ1dCBpc24ndCBwcm9wZXJseSBpbXBsZW1lbnRlZC4gT3Ro
ZXJ3aXNlIGl0J3Mgb25seSBhDQo+IG5ldyBmZWF0dXJlLg0KPiANCg0KSXQncyBvbmx5IGEgbmV3
IGZlYXR1cmUuDQoNCldpdGhvdXQgdGhpcyBwYXRjaCwgcHdtX21lZGlhdGVrX2NvbmZpZyByZXR1
cm4gLUVJTlZBTCB3aGVuIHJlY2VpdmUgYQ0KbG9uZyBwZXJpb2QgcmVxdWVzdC4NCg0KSSB3aWxs
IHNlbmQgdjMgdG8gcmVwbHkgVXdlJ3MgY29tbWVudC4NCg0KDQpCZXN0IFJlZ2FyZHMsDQpTYW0g
U2hpaA0KDQo=

