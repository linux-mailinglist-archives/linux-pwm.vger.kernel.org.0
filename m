Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 748571773D5
	for <lists+linux-pwm@lfdr.de>; Tue,  3 Mar 2020 11:19:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgCCKTW (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Tue, 3 Mar 2020 05:19:22 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:12909 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726661AbgCCKTW (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Tue, 3 Mar 2020 05:19:22 -0500
X-UUID: ed07c36a91084c9993d6f28dde738233-20200303
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=+FkgnuhMth6UFDfn+Y38HmyJc9tDM2pj8gHrymrjp7Y=;
        b=QBvydKp/VDcMgtpz080lQsrzctzF3az6GAHlo0/P1ikAI+6+1e1/CcB1VkcZYaxDORpttZOW76wCxGIBzGqbNYeATWR0zt8wkhdbIQqbrJTGpz0hxXitpPm9Q9mEMo7mJtosENweF/VB0ZdP8Thg6ESatuE8LK3hkPCpO5v7ow0=;
X-UUID: ed07c36a91084c9993d6f28dde738233-20200303
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 896245368; Tue, 03 Mar 2020 18:19:18 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 3 Mar 2020 18:18:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 3 Mar 2020 18:19:14 +0800
From:   Sam Shih <sam.shih@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     John Crispin <john@phrozen.org>, <linux-pwm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Sam Shih <sam.shih@mediatek.com>
Subject: [PATCH v2 0/1] pwm: mediatek: add longer period support
Date:   Tue, 3 Mar 2020 18:19:14 +0800
Message-ID: <1583230755-25986-1-git-send-email-sam.shih@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

VGhpcyBwYXRjaCBhZGQgc3VwcG9ydCBmb3IgbG9uZ2VyIHB3bSBwZXJpb2QgY29uZmlndXJhdGlv
biwNCndoaWNoIGFsbG93aW5nIGJsaW5raW5nIExFRHMgdmlhIHB3bSBpbnRlcmZhY2UuDQoNClNh
bSBTaGloICgxKToNCiAgcHdtOiBtZWRpYXRlazogYWRkIGxvbmdlciBwZXJpb2Qgc3VwcG9ydA0K
DQogZHJpdmVycy9wd20vcHdtLW1lZGlhdGVrLmMgfCAzNCArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKystLS0tDQogMSBmaWxlIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pDQoNCi0tIA0KMi4xNy4xDQo=

