Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3CA122250
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2019 04:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbfLQDEn (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Dec 2019 22:04:43 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:21677 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725836AbfLQDEn (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Dec 2019 22:04:43 -0500
X-UUID: 490c6d601899469aa882730409cc7b83-20191217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=qm8ZVdor7mNZWjwtUCeGe4UHjn0nNnmELYKhUtCwThA=;
        b=eUG177DyNscYODcWuNP6GRwHGyPmQdjjHgvyyhy2icNka+v9EpqQwF0367IEI52t5nJG+5QEXoL/0oZUGCr4MlkqDFNFkUPoeX6F2nBvzbLnQU5KQTjjsbC1I9O1Ev4S5O9ZaE7f6vPHIpcit2UhmxooONxEBDclZ0UtzEjxK9s=;
X-UUID: 490c6d601899469aa882730409cc7b83-20191217
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 902721692; Tue, 17 Dec 2019 11:04:39 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 17 Dec
 2019 11:04:57 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 17 Dec 2019 11:04:15 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, CK Hu <ck.hu@mediatek.com>
CC:     <linux-mediatek@lists.infradead.org>, <sj.huang@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v3 0/2] clocks don't disable when pwm_mtk_disp suspend
Date:   Tue, 17 Dec 2019 11:04:36 +0800
Message-ID: <20191217030438.26657-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: B45B89466AD61F6801130090D3FB783A9D5C598C4FD4786A4B8EABA82491DA7C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB0byB2MjoNCiAtIEVkaXQgY29tbWl0IG1zZy4NCg0KQ2hhbmdlcyBzaW5j
ZSB0byB2MToNCiAtIEVkaXQgY29tbWl0IG1zZy4NCiAtIFJlbW92ZSB0aGUgcmVnaXN0ZXIgdHJp
Z2dlciBpbiBwcm9iZS4NCiAtIFJlYmFzZSB0byB2NS41LXJjMS4NCg0KQ2hhbmdlcyBpbiBwYXRj
aGVzOg0KIC0gbWF0Y2ggcHdtX210a19kaXNwIGNsb2NrIHdoZW4gc3VzcGVuZC9yZXN1bWUNCiAt
IHRyaWdnZXIgcHdtX210a19kaXNwIHJlZyB3b3JraW5nIGFmdGVyIGNvbmZpZw0KDQpKaXRhbyBT
aGkgKDIpOg0KICBwd206IGZpeCBwd20gY2xvY2tzIG5vdCBwb3dlcm9mZiB3aGVuIGRpc2FibGUg
cHdtDQogIHB3bToga2VlcCB0aGUgdHJpZ2dlciByZWdpc3RlciBhZnRlciBwd20gc2V0dGluZy4N
Cg0KIGRyaXZlcnMvcHdtL3B3bS1tdGstZGlzcC5jIHwgNjMgKysrKysrKysrKysrLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgNDQg
ZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4yMS4wDQo=

