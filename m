Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD8789417
	for <lists+linux-pwm@lfdr.de>; Sun, 11 Aug 2019 23:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbfHKVLZ (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Sun, 11 Aug 2019 17:11:25 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:47258 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbfHKVLZ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Sun, 11 Aug 2019 17:11:25 -0400
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id CB5CF2002B;
        Sun, 11 Aug 2019 23:11:19 +0200 (CEST)
Date:   Sun, 11 Aug 2019 23:11:18 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Jitao Shi <jitao.shi@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        linux-pwm@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Matthias Brugger <matthias.bgg@gmail.com>, stonea168@163.com,
        dri-devel@lists.freedesktop.org,
        Andy Yan <andy.yan@rock-chips.com>,
        Ajay Kumar <ajaykumar.rs@samsung.com>,
        Vincent Palatin <vpalatin@chromium.org>,
        cawa.cheng@mediatek.com,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Thierry Reding <treding@nvidia.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        yingjoe.chen@mediatek.com, eddie.huang@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        Rahul Sharma <rahul.sharma@samsung.com>,
        srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
        Sascha Hauer <kernel@pengutronix.de>,
        Sean Paul <seanpaul@chromium.org>
Subject: Re: [PATCH v4 0/4] Add drivers for auo, kd101n80-45na and boe,
 tv101wum-nl6 panels
Message-ID: <20190811211118.GA23636@ravnborg.org>
References: <20190811091001.49555-1-jitao.shi@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190811091001.49555-1-jitao.shi@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10
        a=pdzb0zgU1xEUnBsD4PIA:9 a=CjuIK1q_8ugA:10
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi Jitao.

>  .../display/panel/auo,kd101n80-45na.txt       |  34 +
>  .../display/panel/boe,tv101wum-nl6.txt        |  34 +

panel bindings are in the process of being migrated to the new
meta-schema format.
Therefore new bindings should preferably also follow the new format.

Can you please look into this.
In upstream and drm-misc-next there is already some examples.

Note: It is not a hard rule that new bindings shall be in
the new meta-schema format (.yaml extension), but as this is
best practice now it is preferred.
Same goes for display bindings btw.

	Sam
