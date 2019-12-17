Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD141222CD
	for <lists+linux-pwm@lfdr.de>; Tue, 17 Dec 2019 05:02:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbfLQECi (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 16 Dec 2019 23:02:38 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:55599 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726296AbfLQECi (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 16 Dec 2019 23:02:38 -0500
X-UUID: 7d3e697c2aef4f319a6c993d55f4d381-20191217
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=LcLrXW4EHYAgtWmQrzXHi1JpCH+lQx2E8V9kumhc1ek=;
        b=ZIs74pl5lssvFLZCzD4ajsXIu7IcqrRovCUTYrRZuSmWkbhdneIG4hEoZyjqTr8txuA/BUgPzn4lOzFAcXLMwyP8WHMzeNBFjH/HoqFm2OW+UQmGzc2RyfkBLgu79oq7SnHNn4vb1HcrhgxXh6mQUvIF7kN6U0oDpyZCamHiqE0=;
X-UUID: 7d3e697c2aef4f319a6c993d55f4d381-20191217
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jitao.shi@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 1300660505; Tue, 17 Dec 2019 12:02:33 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS33N1.mediatek.inc
 (172.27.4.75) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 17 Dec
 2019 12:01:37 +0800
Received: from mszsdclx1018.gcn.mediatek.inc (172.27.4.253) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1395.4 via Frontend Transport; Tue, 17 Dec 2019 12:02:10 +0800
From:   Jitao Shi <jitao.shi@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pwm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, CK Hu <ck.hu@mediatek.com>
CC:     <linux-mediatek@lists.infradead.org>, <sj.huang@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>
Subject: [PATCH v4 0/2] clocks aren't disable when pwm_mtk_disp suspend 
Date:   Tue, 17 Dec 2019 12:02:35 +0800
Message-ID: <20191217040237.28238-1-jitao.shi@mediatek.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: C18B4FA8F365099FC353D7DEAA8518A47E29E60775599306885E0B2F2365AEAE2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Q2hhbmdlcyBzaW5jZSB0byB2MzoNCiAtIEFkZCBwcmVmaXggInB3bTogbXRrX2Rpc3AiIGluIGNv
bW1pdCBtc2cgdGl0bGUuDQoNCkNoYW5nZXMgc2luY2UgdG8gdjI6DQogLSBFZGl0IGNvbW1pdCBt
c2cuDQoNCkNoYW5nZXMgc2luY2UgdG8gdjE6DQogLSBFZGl0IGNvbW1pdCBtc2cuDQogLSBSZW1v
dmUgdGhlIHJlZ2lzdGVyIHRyaWdnZXIgaW4gcHJvYmUuDQogLSBSZWJhc2UgdG8gdjUuNS1yYzEu
DQoNCkNoYW5nZXMgaW4gcGF0Y2hlczoNCiAtIG1hdGNoIHB3bV9tdGtfZGlzcCBjbG9jayB3aGVu
IHN1c3BlbmQvcmVzdW1lDQogLSB0cmlnZ2VyIHB3bV9tdGtfZGlzcCByZWcgd29ya2luZyBhZnRl
ciBjb25maWcNCg0KSml0YW8gU2hpICgyKToNCiAgcHdtOiBtdGtfZGlzcDogZml4IHB3bSBjbG9j
a3Mgbm90IHBvd2Vyb2ZmIHdoZW4gZGlzYWJsZSBwd20NCiAgcHdtOiBtdGtfZGlzcDoga2VlcCB0
aGUgdHJpZ2dlciByZWdpc3RlciBhZnRlciBwd20gc2V0dGluZy4NCg0KIGRyaXZlcnMvcHdtL3B3
bS1tdGstZGlzcC5jIHwgNjMgKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
CiAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgNDQgZGVsZXRpb25zKC0pDQoNCi0t
IA0KMi4yMS4wDQo=

