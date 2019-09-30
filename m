Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 693BEC1D6A
	for <lists+linux-pwm@lfdr.de>; Mon, 30 Sep 2019 10:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729953AbfI3IvR (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Mon, 30 Sep 2019 04:51:17 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:63238 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726008AbfI3IvQ (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Mon, 30 Sep 2019 04:51:16 -0400
X-UUID: 6f8aa737f23f496cbbcd03217376e47f-20190930
X-UUID: 6f8aa737f23f496cbbcd03217376e47f-20190930
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 249343122; Mon, 30 Sep 2019 16:51:10 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 30 Sep 2019 16:51:06 +0800
Received: from [172.21.84.99] (172.21.84.99) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Mon, 30 Sep 2019 16:51:06 +0800
Message-ID: <1569833468.32131.4.camel@mtksdccf07>
Subject: Re: [PATCH v10 08/12] pwm: mediatek: Add MT7629 compatible string
From:   Sam Shih <sam.shih@mediatek.com>
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        John Crispin <john@phrozen.org>, <linux-pwm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Mon, 30 Sep 2019 16:51:08 +0800
In-Reply-To: <20190927112831.GA1171568@ulmo>
References: <1569421957-20765-1-git-send-email-sam.shih@mediatek.com>
         <1569421957-20765-9-git-send-email-sam.shih@mediatek.com>
         <20190927112831.GA1171568@ulmo>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-SNTS-SMTP: 117A8A6215936262384F6F70692A074F4A2330135B41FEF58EBF2008F4C56AEB2000:8
X-MTK:  N
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

Hi,

On Fri, 2019-09-27 at 13:28 +0200, Thierry Reding wrote:
> On Wed, Sep 25, 2019 at 10:32:33PM +0800, Sam Shih wrote:
> > This adds pwm support for MT7629, and separate mt7629 compatible string
> > from mt7622
> > 
> > Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> > ---
> >  drivers/pwm/pwm-mediatek.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> 
> I picked this patch up and made some minor adjustments to make it build
> without the num_pwms patches. With that I don't think there's anything
> left from this series that you need.

Yes, I think the driver should work once dtsi updated.
("[v10,12/12] arm: dts: mediatek: add mt7629 pwm support")

But, due to we use comaptible string separately for every SoC now,
The comaptible string in dt-bindings should be "mediatek,mt7629-pwm".
I think we should use "[v10,11/12] dt-bindings: pwm: update bindings 
for MT7629" to replace commit 1c00ad6ebf36aa3b0fa598a48b8ae59782be4121,
Or maybe we need a little modification like this ?
diff --git a/Documentation/devicetree/bindings/pwm/pwm-mediatek.txt ...
- - "mediatek,mt7629-pwm", "mediatek,mt7622-pwm": found on mt7629 SoC.
+ - "mediatek,mt7629-pwm": found on mt7629 SoC.

Thanks,
Regards, Sam

