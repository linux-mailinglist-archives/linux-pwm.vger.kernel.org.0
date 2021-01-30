Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 866C23095D0
	for <lists+linux-pwm@lfdr.de>; Sat, 30 Jan 2021 15:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbhA3OOS (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sat, 30 Jan 2021 09:14:18 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:63566 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231783AbhA3ON5 (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sat, 30 Jan 2021 09:13:57 -0500
X-UUID: 75891c7ccce04862ba908eefaa5ba124-20210130
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=0EHa8G4GCy+novOwU6OJI2yK0pPjlAP1l0rYdaET5P8=;
        b=nDuaPGHO4GWeEuj2PdzZBdm7FNHBK3giCGoW3DGn6O5Kq0HicZ71sUMKw/P8BTPjotsM5ZAUAzHi/7VtQLqOggidoC3RdGMHDB0MlR6qojXeHbCgI8hVZ1tAL4221JTls8GMkv76HzdskX3YxQk1hobuwbCBGaWrzx1irXDHNQU=;
X-UUID: 75891c7ccce04862ba908eefaa5ba124-20210130
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1884248618; Sat, 30 Jan 2021 22:12:32 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 30 Jan
 2021 22:12:29 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sat, 30 Jan 2021 22:12:29 +0800
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
Subject: [PATCH v2 0/3] Convert the mtk_disp driver to aotmic API
Date:   Sat, 30 Jan 2021 22:12:23 +0800
Message-ID: <20210130141226.25357-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.12.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: ACFC5FED0B4CBE8DE67FFFBAE3EE08092F9D118AD2DF692C187DF2B2441CBB4A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB2MToNCiAtIFNlcGVyYXRlIGNsb2NrIG9wZXJhdGlvbiBhcyBzaW5nbGUg
cGF0Y2guDQogLSBTZXBlcmF0ZSBhcHBseSgpIGFzIHNpbmdsZSBwYXRjaC4NCiAtIFNlcGVyYXRl
IGdldF9zdGF0ZSgpIG9wZXJhdGlvbiBhcyBzaW5nbGUgcGF0Y2guDQoNCkppdGFvIFNoaSAoMyk6
DQogIHB3bTogbXRrX2Rpc3A6IGNsZWFyIHRoZSBjbG9jayBvcGVyYXRpb25zDQogIHB3bTogbXRr
X2Rpc3A6IGNvbnZlcnQgdGhlIGRyaXZlciB0byBhdG9taWMgQVBJDQogIHB3bTogbXRrX2Rpc3A6
IGltcGxlbWVudCAuZ2V0X3N0YXRlKCkNCg0KIGRyaXZlcnMvcHdtL3B3bS1tdGstZGlzcC5jIHwg
MTc5ICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIDEgZmls
ZSBjaGFuZ2VkLCAxMDQgaW5zZXJ0aW9ucygrKSwgNzUgZGVsZXRpb25zKC0pDQoNCi0tIA0KMi4x
Mi41DQo=

