Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95219390E77
	for <lists+linux-pwm@lfdr.de>; Wed, 26 May 2021 04:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbhEZCud (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 25 May 2021 22:50:33 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:17289 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232558AbhEZCuc (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 25 May 2021 22:50:32 -0400
X-UUID: 14cf6aa0b36f44fa9deb587f394fc97a-20210526
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=IvFU8sypoO0O+6V1djFvlbjXmsP30PJ1htIWDI3JDUM=;
        b=chK1UaGfG72a789g1KHfC7FOaVZq8FW4lr/ZtIbArV3gH69/XxiHCe5mmkF1r1VE4Ou6BfwfeRJ1NzL8JktFUhDMf2Pr4zcgF66q9ntYCRGqjIMfAP4pBTCACSQpkfQh8LLj1aaSSHzejfrKX0O+mhwHxzz6nx7Op6ZW1mo+LGU=;
X-UUID: 14cf6aa0b36f44fa9deb587f394fc97a-20210526
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1346147304; Wed, 26 May 2021 10:48:56 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N2.mediatek.inc
 (172.27.4.76) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 26 May
 2021 10:48:48 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (10.16.6.18) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 26 May 2021 10:48:47 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <yingjoe.chen@mediatek.com>, <eddie.huang@mediatek.com>,
        <cawa.cheng@mediatek.com>, <bibby.hsieh@mediatek.com>,
        <ck.hu@mediatek.com>, <stonea168@163.com>,
        <huijuan.xie@mediatek.com>, Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v3 0/3] Convert the mtk_disp driver to aotmic API
Date:   Wed, 26 May 2021 10:48:43 +0800
Message-ID: <20210526024846.120838-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: AF1C3E7F7F6D04596C943736E5FC00377541B87B3AB3C359648FC3C94E07AAF62000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Q2hhbmdlIHNpbmNlIHYyOg0KIC0gQ2hhbmdlIGNvbW1pdCBtZXNzYWdlcyB0byByZW1vdmUgdGhl
IGNsb2NrIG9wZXJhdGlvbnMgZm9yIGF0b21pYyBBUElzLg0KIC0gUmViYXNlIHRvIHY1LjEzIHJj
MQ0KDQpDaGFuZ2VzIHNpbmNlIHYxOg0KIC0gU2VwZXJhdGUgY2xvY2sgb3BlcmF0aW9uIGFzIHNp
bmdsZSBwYXRjaC4NCiAtIFNlcGVyYXRlIGFwcGx5KCkgYXMgc2luZ2xlIHBhdGNoLg0KIC0gU2Vw
ZXJhdGUgZ2V0X3N0YXRlKCkgb3BlcmF0aW9uIGFzIHNpbmdsZSBwYXRjaC4NCg0KSml0YW8gU2hp
ICgzKToNCiAgcHdtOiBtdGtfZGlzcDogcmVtb3ZlIHRoZSBjbG9jayBvcGVyYXRpb25zIGZvciBh
dG9taWMgQVBJcy4NCiAgcHdtOiBtdGtfZGlzcDogaW1wbGVtZW50IGF0b21pYyBBUEkgLmFwcGx5
KCkNCiAgcHdtOiBtdGtfZGlzcDogaW1wbGVtZW50IGF0b21pYyBBUEkgLmdldF9zdGF0ZSgpDQoN
CiBkcml2ZXJzL3B3bS9wd20tbXRrLWRpc3AuYyB8IDE3NyArKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQsIDEwMiBpbnNlcnRpb25zKCspLCA3NSBk
ZWxldGlvbnMoLSkNCg0KLS0gDQoyLjI1LjENCg==

