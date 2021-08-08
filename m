Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 560C33E3A6A
	for <lists+linux-pwm@lfdr.de>; Sun,  8 Aug 2021 15:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhHHNZg (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 8 Aug 2021 09:25:36 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:18337 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231389AbhHHNZG (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 8 Aug 2021 09:25:06 -0400
X-UUID: 7c0a2183e73c4ec79d6c8fbd2bfe6af6-20210808
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=DH+JvxcpFmH/JD3x/VcfBcOYr5jsLwTN47dk/7b+Smg=;
        b=N4Upw8vBZ1qlD1PTiV5CBmyKQ/NVhn+x00L3zlYJjQKY/XrtqDikz48WeRT2VQwL34Is3xxlSmaH+3+N4nulvYt4dVj9xSDuckJm7nvCXxkV8gKGFgI4VPyD/IuUrCTZUo1LnQk9dgeVrVO6bHBF+0ZrzGfGzRoUtkSQQfep3r0=;
X-UUID: 7c0a2183e73c4ec79d6c8fbd2bfe6af6-20210808
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1075637577; Sun, 08 Aug 2021 21:24:40 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 8 Aug
 2021 21:24:36 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sun, 8 Aug 2021 21:24:35 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <ck.hu@mediatek.com>, <stonea168@163.com>,
        <huijuan.xie@mediatek.com>, <shuijing.li@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v7 0/5] fix the clks on/off mismatch issue and switch pwm-mtk-disp to atomic APIs
Date:   Sun, 8 Aug 2021 21:24:28 +0800
Message-ID: <20210808132433.66037-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C68C7A9E77DD9526444DEE733F4D592E879711FEE47D07414BBC1577EDA3ECF02000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB2NjoNCiAtIGZpeCBjb21taXQgbXNnIG9mICJwd206IG10a19kaXNwOiBm
aXggZm9yY2UgcmVnIHRvIHdvcmtpbmcgcmVnIi4NCiAgIEV4cGFpbiB0aGUgcmVnIGFjY2VzcyBv
bmx5IHdoZW4gbW0gYW5kIG1haW4gY2xvY2sgb24uDQoNCkNoYW5nZXMgc2luY2UgdjU6DQogLSBm
aXggb3ZlcmZsb3cuDQogLSBTZXBlcmF0ZSB0aGUgcmVnIHNoYWRvdyBhcyBhIHNpbmdsZSBwYXRj
aC4NCg0KQ2hhbmdlcyBzaW5jZSB2NDoNCiAtIFNxdWFzaCB0aGUgY29tbWl0ICJtb3ZlIHRoZSBj
b21taXQgdG8gY2xvY2sgZW5hYmxlZCIgdG8gImFkanVzdCB0aGUgY2xvY2tzIHRvIGF2b2lkIHRo
ZW0gbWlzbWF0Y2giLg0KIC0gRHJvcCB0aGUgdXNlbGVzcyBjb21tZW50IGFib3V0IE1UMjcwMS4N
CiAtIFJlZW5hYmxlIHRoZSBjbGtzICJtbSIgYW5kICJtYWluIiBpbiAuZW5hYmxlKCkuDQogLSBG
aXggdHlwby4NCiAtIFNlcGVyYXRlIGdldF9zdGF0ZSgpIG9wZXJhdGlvbiBhcyBzaW5nbGUgcGF0
Y2guDQoNCkNoYW5nZXMgc2luY2UgdjM6DQogLSBTZXBlcmF0ZSB0aGUgY2xvY2sgc2VxdWVuY2Ug
YXMgc2luZ2xlIHBhdGNoLg0KIC0gRml4dXAgdGhlIHJlZyBjb21taXQgd2hlbiBjbG9ja3Mgc2Vx
dWVuY2UgY2hhbmdlZC4NCiAtIE1lcmdlIHRoZSBhcHBseSBhbmQgZ2V0X3N0YXRlIGFzIHNpbmds
ZSBwYXRjaC4NCg0KQ2hhbmdlcyBzaW5jZSB2MjoNCiAtIENoYW5nZSBjb21taXQgbWVzc2FnZXMg
dG8gcmVtb3ZlIHRoZSBjbG9jayBvcGVyYXRpb25zIGZvciBhdG9taWMgQVBJcy4NCiAtIFJlYmFz
ZSB0byB2NS4xMyByYzEuDQoNCkNoYW5nZXMgc2luY2UgdjE6DQogLSBTZXBlcmF0ZSBjbG9jayBv
cGVyYXRpb24gYXMgc2luZ2xlIHBhdGNoLg0KIC0gU2VwZXJhdGUgYXBwbHkoKSBhcyBzaW5nbGUg
cGF0Y2guDQogLSBTZXBlcmF0ZSBnZXRfc3RhdGUoKSBvcGVyYXRpb24gYXMgc2luZ2xlIHBhdGNo
Lg0KDQpKaXRhbyBTaGkgKDUpOg0KICBwd206IG10ay1kaXNwOiBhZGp1c3QgdGhlIGNsb2NrcyB0
byBhdm9pZCB0aGVtIG1pc21hdGNoDQogIHB3bTogbXRrX2Rpc3A6IGZpeCBmb3JjZSByZWcgdG8g
d29ya2luZyByZWcuDQogIHB3bTogbXRrX2Rpc3A6IGltcGxlbWVudCBhdG9taWMgQVBJIC5hcHBs
eSgpDQogIHB3bTogbXRrX2Rpc3A6IGZpeCBvdmVyZmxvdyBpbiBwZXJpb2QgYW5kIGR1dHkgY2Fs
Y2FsYXRpb24NCiAgcHdtOiBtdGtfZGlzcDogaW1wbGVtZW50IGF0b21pYyBBUEkgLmdldF9zdGF0
ZSgpDQoNCiBkcml2ZXJzL3B3bS9wd20tbXRrLWRpc3AuYyB8IDE3MiArKysrKysrKysrKysrKysr
KysrKy0tLS0tLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDkyIGluc2VydGlvbnMoKyks
IDgwIGRlbGV0aW9ucygtKQ0KDQotLSANCjIuMjUuMQ0K

