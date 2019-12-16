Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D07E11FEB5
	for <lists+linux-pwm@lfdr.de>; Mon, 16 Dec 2019 08:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfLPHBc (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Dec 2019 02:01:32 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:15425 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726054AbfLPHBb (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Dec 2019 02:01:31 -0500
X-UUID: 6a9a147d30274ec396ca518aa9cdd99b-20191216
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=OgROpEIhh+7JoSk/mlmx76ruWwDI5qaudXsOyA/2J1U=;
        b=SZtUzJjodDrPtn0UcqacbcSz9+IofzxNSSq0smC+M4AfCtTehIcvxIZG4PqeSWQuh8U/oPLGM3nk6aqDP0cOYoVTNiIQQ29gmqrxIGHSqZCHAYvXHxK+7uuln6L56zDH5GqX8tjhU4MOVt4sVjfvFR5x/N8qTQKxiGsl1jceW3w=;
X-UUID: 6a9a147d30274ec396ca518aa9cdd99b-20191216
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1430781416; Mon, 16 Dec 2019 15:01:22 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Mon, 16 Dec
 2019 15:01:40 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Mon, 16 Dec 2019 15:01:02 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, CK Hu <ck.hu@mediatek.com>
CC:     <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <sj.huang@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v2 0/2] pwm_mtk_disp suspend resume issue fix
Date:   Mon, 16 Dec 2019 15:01:21 +0800
Message-ID: <20191216070123.114719-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: FD417AFFB53D0E358027859FF6FDC788B0702CA0534DA0C3FEF7EDAD6D821C6A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB0byB2MToNCiAtIEVkaXQgY29tbWl0IG1zZy4NCiAtIFJlbW92ZSB0aGUg
cmVnaXN0ZXIgdHJpZ2dlciBpbiBwcm9iZS4NCiAtIFJlYmFzZSB0byB2NS41LXJjMS4NCg0KQ2hh
bmdlcyBpbiBwYXRjaGVzOg0KIC0gbWF0Y2ggcHdtX210a19kaXNwIGNsb2NrIHdoZW4gc3VzcGVu
ZC9yZXN1bWUNCiAtIHRyaWdnZXIgcHdtX210a19kaXNwIHJlZyB3b3JraW5nIGFmdGVyIGNvbmZp
Zw0KDQpKaXRhbyBTaGkgKDIpOg0KICBwd206IGZpbmUgdHVuZSBwd20tbXRrLWRpc3AgY2xvY2sg
Y29udHJvbCBmbG93DQogIHB3bS9tdGtfZGlzcDogbW92ZSB0aGUgcmVnIGVuYWJsZSB0cmlnZ2Vy
IGluIGNvbmZpZw0KDQogZHJpdmVycy9wd20vcHdtLW10ay1kaXNwLmMgfCA2MyArKysrKysrKysr
KystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRp
b25zKCspLCA0NCBkZWxldGlvbnMoLSkNCg0KLS0gDQoyLjIxLjANCg==

