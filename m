Return-Path: <linux-pwm-owner@vger.kernel.org>
X-Original-To: lists+linux-pwm@lfdr.de
Delivered-To: lists+linux-pwm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E6822B4C9
	for <lists+linux-pwm@lfdr.de>; Thu, 23 Jul 2020 19:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgGWR1G (ORCPT <rfc822;lists+linux-pwm@lfdr.de>);
        Thu, 23 Jul 2020 13:27:06 -0400
Received: from a27-30.smtp-out.us-west-2.amazonses.com ([54.240.27.30]:34048
        "EHLO a27-30.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726650AbgGWR1F (ORCPT
        <rfc822;linux-pwm@vger.kernel.org>); Thu, 23 Jul 2020 13:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=7jvkchcrhflv7qhbkgrcypyraifp65wy; d=rt.linuxfoundation.org;
        t=1595525225;
        h=Subject:From:Reply-To:In-Reply-To:References:Message-ID:CC:Content-Type:Date:MIME-Version:Content-Transfer-Encoding;
        bh=HfUzMlrFXx66FVX8OwXPJlKU2j98qbI65IZCB6gOD5k=;
        b=HEYwxnTIiKZE+rQyd106UmLmhEzdDYY5pcgTSaP8Pp+9vME9u9hsnwpyVUSYaDBF
        P2cNn0WFUEHCzk/G/xsi4x0pYiMAzhG04OjJT9W1RJjiRIAYCJ641SoaMAD5PTo43/w
        1ijCIxLQ8JnQnCPPX1d2PUaMmafyI45NScvw8W/U=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1595525225;
        h=Subject:From:Reply-To:In-Reply-To:References:Message-ID:CC:Content-Type:Date:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
        bh=HfUzMlrFXx66FVX8OwXPJlKU2j98qbI65IZCB6gOD5k=;
        b=fu5HhqaGTyLsEfSU/e9RqOx88W8Wgupx5757GNrspOcgQV3249FGH/sH+VNT4REb
        6DSLi1qO0NTop/lKleiSCBlWl58swB2l/7EVwPIQPGDCjEwHMLi0xwdLfdYOMHhtgzq
        v+8OQeV+O39Okfo28AzcwVU97vK7yNMH+Mv59i1o=
Subject: Re: [Kernel.org Helpdesk #89942] Re: adding linux-pwm archives to lore.kernel.org?
From:   "=?UTF-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= via RT" 
        <kernel-helpdesk@rt.linuxfoundation.org>
Reply-To: kernel-helpdesk@rt.linuxfoundation.org
In-Reply-To: <20200723172702.nirnet6tbmwuwd57@pengutronix.de>
References: <RT-Ticket-89942@linuxfoundation>
 <20200213102618.x5j6kfvqmdbx2pr2@pengutronix.de>
 <20200523170558.h2brqlf2jx4kee6y@pengutronix.de>
 <20200613141533.ak3nyo5hu636evwq@taurus.defre.kleine-koenig.org>
 <20200709092659.drrmvv53qs2q4lid@pengutronix.de>
 <rt-4.4.0-1686-1594286826-1167.89942-6-0@linuxfoundation>
 <010101734f397f00-39d54a81-d06d-4947-b9fc-332e9f9b46d5-000000@us-west-2.amazonses.com> <20200723172702.nirnet6tbmwuwd57@pengutronix.de>
Message-ID: <010101737cb6d9ae-f070007e-1c58-46ab-aaef-4c943347cf32-000000@us-west-2.amazonses.com>
X-RT-Loop-Prevention: linuxfoundation.org
X-RT-Ticket: linuxfoundation.org #89942
X-Managed-BY: RT 4.4.0 (http://www.bestpractical.com/rt/)
X-RT-Originator: u.kleine-koenig@pengutronix.de
CC:     linux-pwm@vger.kernel.org, thierry.reding@gmail.com
X-RT-Original-Encoding: utf-8
Content-Type: multipart/mixed; boundary="----------=_1595525224-492-1300"
Date:   Thu, 23 Jul 2020 17:27:04 +0000
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2020.07.23-54.240.27.30
Feedback-ID: 1.us-west-2.3ULHQnc20aILdVzjlbQ8UqO1WRWzA1U01b2uFAcT62w=:AmazonSES
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-pwm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pwm.vger.kernel.org>
X-Mailing-List: linux-pwm@vger.kernel.org

This is a multi-part message in MIME format...

------------=_1595525224-492-1300
Content-Type: text/plain; charset="utf-8"

Hello,

On Tue, Jul 14, 2020 at 09:27:14PM +0000, Konstantin Ryabitsev via RT wrote:
> On 2020-07-09 05:27:06, u.kleine-koenig@pengutronix.de wrote:
> > Hello Konstantin(?),
> 
> I'm sorry, apparently I screwed up and didn't assign this ticket to
> anyone when it came in. I was dutifully ignoring follow-ups, as I'd
> assumed someone else would be responding.
> 
> Chris, I've properly assigned it to you now -- can you please
> prioritise this request, as time allows?

Last week I thought this is a no-brainer now and will be done in a few
hours. It seems I was wrong :-|

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |


------------=_1595525224-492-1300
Content-Type: application/x-rt-original-message
Content-Disposition: inline
Content-Transfer-Encoding: base64
RT-Attachment: 89942/2044000/1707905

RnJvbSB1a2xAcGVuZ3V0cm9uaXguZGUgIFRodSBKdWwgMjMgMTc6Mjc6MDQg
MjAyMApSZXR1cm4tUGF0aDogPHVrbEBwZW5ndXRyb25peC5kZT4KWC1Pcmln
aW5hbC1Ubzoga2VybmVsLWhlbHBkZXNrQHJ0LmxpbnV4Zm91bmRhdGlvbi5v
cmcKRGVsaXZlcmVkLVRvOiBrZXJuZWwtaGVscGRlc2tAcnQubGludXhmb3Vu
ZGF0aW9uLm9yZwpSZWNlaXZlZDogZnJvbSBtZXRpcy5leHQucGVuZ3V0cm9u
aXguZGUgKG1ldGlzLmV4dC5wZW5ndXRyb25peC5kZSBbODUuMjIwLjE2NS43
MV0pCglieSBhd3MtdXMtd2VzdC0yLWxmaXQtcnQtMS53ZWIuY29kZWF1cm9y
YS5vcmcgKFBvc3RmaXgpIHdpdGggRVNNVFAgaWQgMjFFQ0RDNDMzQ0IKCWZv
ciA8a2VybmVsLWhlbHBkZXNrQHJ0LmxpbnV4Zm91bmRhdGlvbi5vcmc+OyBU
aHUsIDIzIEp1bCAyMDIwIDE3OjI3OjA0ICswMDAwIChVVEMpClJlY2VpdmVk
OiBmcm9tIHB0eS5oaS5wZW5ndXRyb25peC5kZSAoWzIwMDE6NjdjOjY3MDox
MDA6MWQ6OmM1XSkKCWJ5IG1ldGlzLmV4dC5wZW5ndXRyb25peC5kZSB3aXRo
IGVzbXRwcyAoVExTMS4yOkVDREhFX1JTQV9BRVNfMjU2X0dDTV9TSEEzODQ6
MjU2KQoJKEV4aW0gNC45MikKCShlbnZlbG9wZS1mcm9tIDx1a2xAcGVuZ3V0
cm9uaXguZGU+KQoJaWQgMWp5ZXpuLTAwMDdVRC0wcTsgVGh1LCAyMyBKdWwg
MjAyMCAxOToyNzowMyArMDIwMApSZWNlaXZlZDogZnJvbSB1a2wgYnkgcHR5
LmhpLnBlbmd1dHJvbml4LmRlIHdpdGggbG9jYWwgKEV4aW0gNC44OSkKCShl
bnZlbG9wZS1mcm9tIDx1a2xAcGVuZ3V0cm9uaXguZGU+KQoJaWQgMWp5ZXpt
LTAwMDA3by03SzsgVGh1LCAyMyBKdWwgMjAyMCAxOToyNzowMiArMDIwMApE
YXRlOiBUaHUsIDIzIEp1bCAyMDIwIDE5OjI3OjAyICswMjAwCkZyb206IFV3
ZSA9P3V0Zi04P1E/S2xlaW5lLUs9QzM9QjZuaWc/PSA8dS5rbGVpbmUta29l
bmlnQHBlbmd1dHJvbml4LmRlPgpUbzogS29uc3RhbnRpbiBSeWFiaXRzZXYg
dmlhIFJUIDxrZXJuZWwtaGVscGRlc2tAcnQubGludXhmb3VuZGF0aW9uLm9y
Zz4KQ2M6IGxpbnV4LXB3bUB2Z2VyLmtlcm5lbC5vcmcsIHRoaWVycnkucmVk
aW5nQGdtYWlsLmNvbQpTdWJqZWN0OiBSZTogW0tlcm5lbC5vcmcgSGVscGRl
c2sgIzg5OTQyXSBSZTogYWRkaW5nIGxpbnV4LXB3bSBhcmNoaXZlcyB0bwog
bG9yZS5rZXJuZWwub3JnPwpNZXNzYWdlLUlEOiA8MjAyMDA3MjMxNzI3MDIu
bmlybmV0NnRibXd1d2Q1N0BwZW5ndXRyb25peC5kZT4KUmVmZXJlbmNlczog
PFJULVRpY2tldC04OTk0MkBsaW51eGZvdW5kYXRpb24+CiA8MjAyMDAyMTMx
MDI2MTgueDVqNmtmdnFtZGJ4MnByMkBwZW5ndXRyb25peC5kZT4KIDwyMDIw
MDUyMzE3MDU1OC5oMmJycWxmMmp4NGtlZTZ5QHBlbmd1dHJvbml4LmRlPgog
PDIwMjAwNjEzMTQxNTMzLmFrM255bzVodTYzNmV2d3FAdGF1cnVzLmRlZnJl
LmtsZWluZS1rb2VuaWcub3JnPgogPDIwMjAwNzA5MDkyNjU5LmRycm12djUz
cXMycTRsaWRAcGVuZ3V0cm9uaXguZGU+CiA8cnQtNC40LjAtMTY4Ni0xNTk0
Mjg2ODI2LTExNjcuODk5NDItNi0wQGxpbnV4Zm91bmRhdGlvbj4KIDwwMTAx
MDE3MzRmMzk3ZjAwLTM5ZDU0YTgxLWQwNmQtNDk0Ny1iOWZjLTMzMmU5Zjli
NDZkNS0wMDAwMDBAdXMtd2VzdC0yLmFtYXpvbnNlcy5jb20+Ck1JTUUtVmVy
c2lvbjogMS4wCkNvbnRlbnQtVHlwZTogbXVsdGlwYXJ0L3NpZ25lZDsgbWlj
YWxnPXBncC1zaGE1MTI7Cglwcm90b2NvbD0iYXBwbGljYXRpb24vcGdwLXNp
Z25hdHVyZSI7IGJvdW5kYXJ5PSJ3NW92aDZnYnVsZGN1ZjZiIgpDb250ZW50
LURpc3Bvc2l0aW9uOiBpbmxpbmUKSW4tUmVwbHktVG86IDwwMTAxMDE3MzRm
Mzk3ZjAwLTM5ZDU0YTgxLWQwNmQtNDk0Ny1iOWZjLTMzMmU5ZjliNDZkNS0w
MDAwMDBAdXMtd2VzdC0yLmFtYXpvbnNlcy5jb20+ClgtU0EtRXhpbS1Db25u
ZWN0LUlQOiAyMDAxOjY3Yzo2NzA6MTAwOjFkOjpjNQpYLVNBLUV4aW0tTWFp
bC1Gcm9tOiB1a2xAcGVuZ3V0cm9uaXguZGUKWC1TQS1FeGltLVNjYW5uZWQ6
IE5vIChvbiBtZXRpcy5leHQucGVuZ3V0cm9uaXguZGUpOyBTQUV4aW1SdW5D
b25kIGV4cGFuZGVkIHRvIGZhbHNlClgtUFRYLU9yaWdpbmFsLVJlY2lwaWVu
dDoga2VybmVsLWhlbHBkZXNrQHJ0LmxpbnV4Zm91bmRhdGlvbi5vcmcKCgot
LXc1b3ZoNmdidWxkY3VmNmIKQ29udGVudC1UeXBlOiB0ZXh0L3BsYWluOyBj
aGFyc2V0PWlzby04ODU5LTEKQ29udGVudC1EaXNwb3NpdGlvbjogaW5saW5l
CkNvbnRlbnQtVHJhbnNmZXItRW5jb2Rpbmc6IHF1b3RlZC1wcmludGFibGUK
CkhlbGxvLAoKT24gVHVlLCBKdWwgMTQsIDIwMjAgYXQgMDk6Mjc6MTRQTSAr
MDAwMCwgS29uc3RhbnRpbiBSeWFiaXRzZXYgdmlhIFJUIHdyb3RlOgo+IE9u
IDIwMjAtMDctMDkgMDU6Mjc6MDYsIHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRy
b25peC5kZSB3cm90ZToKPiA+IEhlbGxvIEtvbnN0YW50aW4oPyksCj49MjAK
PiBJJ20gc29ycnksIGFwcGFyZW50bHkgSSBzY3Jld2VkIHVwIGFuZCBkaWRu
J3QgYXNzaWduIHRoaXMgdGlja2V0IHRvCj4gYW55b25lIHdoZW4gaXQgY2Ft
ZSBpbi4gSSB3YXMgZHV0aWZ1bGx5IGlnbm9yaW5nIGZvbGxvdy11cHMsIGFz
IEknZAo+IGFzc3VtZWQgc29tZW9uZSBlbHNlIHdvdWxkIGJlIHJlc3BvbmRp
bmcuCj49MjAKPiBDaHJpcywgSSd2ZSBwcm9wZXJseSBhc3NpZ25lZCBpdCB0
byB5b3Ugbm93IC0tIGNhbiB5b3UgcGxlYXNlCj4gcHJpb3JpdGlzZSB0aGlz
IHJlcXVlc3QsIGFzIHRpbWUgYWxsb3dzPwoKTGFzdCB3ZWVrIEkgdGhvdWdo
dCB0aGlzIGlzIGEgbm8tYnJhaW5lciBub3cgYW5kIHdpbGwgYmUgZG9uZSBp
biBhIGZldwpob3Vycy4gSXQgc2VlbXMgSSB3YXMgd3JvbmcgOi18CgpCZXN0
IHJlZ2FyZHMKVXdlCgotLT0yMApQZW5ndXRyb25peCBlLksuICAgICAgICAg
ICAgICAgICAgICAgICAgICAgfCBVd2UgS2xlaW5lLUs9RjZuaWcgICAgICAg
ICAgICB8CkluZHVzdHJpYWwgTGludXggU29sdXRpb25zICAgICAgICAgICAg
ICAgICB8IGh0dHBzOi8vd3d3LnBlbmd1dHJvbml4LmRlLyB8CgotLXc1b3Zo
NmdidWxkY3VmNmIKQ29udGVudC1UeXBlOiBhcHBsaWNhdGlvbi9wZ3Atc2ln
bmF0dXJlOyBuYW1lPSJzaWduYXR1cmUuYXNjIgoKLS0tLS1CRUdJTiBQR1Ag
U0lHTkFUVVJFLS0tLS0KCmlRRXpCQUFCQ2dBZEZpRUVmbklxRnBBWXJQOCtk
S1FMd2Z3VWVLM0s3QWtGQWw4WnlHTUFDZ2tRd2Z3VWVLM0sKN0FsMDJ3Zi9a
dHJIOW5QY1RPb0pZTGZCWmNUVHhiNThieUVOVlRITlJZS1dGcEFyMWpkSURo
cmJkVlBLaS9PNApzalhuMTJKWkE0UEJnSUQrU0NLdGIyTlA0YTBCSzEyMFdO
Mmt2N2dNUjQ0SHFSbDM4VVR0UEQwdXNZM1Bhc2pLClMzK3BNOXZETUsxaEFG
bXl3SFprVEpjelV5cXFEczJrekxYYUNFdSs0OXF6Nk9iVkZNYnhHYkdwdjls
a2ozV3QKWlduTjhBVzZqNUpobVg5MFJRMUhIdlkyRWFyYWR2dUVZYllRL1pq
T3ZGUDdTZCtqc0FXcEovWXozZCs4bDlyNgpqNzdKQ2NZbjR4TTdiRG5jNHJv
aGZoa0Uxc0tkVi80WnJzYmNFeldVa3FDejVjMzRPaU41RU5lSFp4OFd3cFU1
CjNFb0xTR2s5TkIyc3BudHVtR0pEMGxxS1lmMHZxUT09Cj0wR2dICi0tLS0t
RU5EIFBHUCBTSUdOQVRVUkUtLS0tLQoKLS13NW92aDZnYnVsZGN1ZjZiLS0K

------------=_1595525224-492-1300--
